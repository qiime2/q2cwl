# ----------------------------------------------------------------------------
# Copyright (c) 2018, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------


import os
import collections

import yaml

import qiime2.sdk as sdk

yaml.add_representer(collections.OrderedDict, lambda dumper, data:
                     dumper.represent_dict(data.items()))

CWL_MAP = {
    'Str': 'string',
    'Int': 'long',
    'Bool': 'boolean',
    'Float': 'double',
    'Color': 'string',
}


Status = collections.namedtuple('Status', ['status', 'action', 'message'])


def root_structure():
    tool = collections.OrderedDict()
    tool['cwlVersion'] = 'v1.0'
    tool['class'] = 'CommandLineTool'
    tool['id'] = None
    tool['requirements'] = collections.OrderedDict()
    tool['label'] = None
    tool['doc'] = None
    tool['inputs'] = collections.OrderedDict()
    tool['baseCommand'] = 'q2cwl-run'
    tool['arguments'] = None
    tool['outputs'] = collections.OrderedDict()

    tool['requirements'] = {
        'InitialWorkDirRequirement': {
            'listing': [
                collections.OrderedDict([('entryname', 'inputs.json'),
                                         ('entry', '{"inputs": $(inputs)}')])
            ]
        }
    }

    return tool


def make_tool(plugin, action, directory, extra_requirements_factory):
    tool = root_structure()
    tool['id'] = action.get_import_path()
    tool['label'] = action.name
    tool['doc'] = action.description


    requirements = extra_requirements_factory()
    requirements.update(tool['requirements'])
    tool['requirements'] = requirements

    tool['arguments'] = [
        plugin.name.replace('-', '_'), action.id, 'inputs.json']

    for name, spec in action.signature.inputs.items():
        tool['inputs'].update(template_input(name, spec))

    for name, spec in action.signature.parameters.items():
        tool['inputs'].update(template_parameters(name, spec))

    for name, spec in action.signature.outputs.items():
        tool['outputs'].update(template_outputs(name, spec))

    return tool


def is_array(qiime_type):
    return qiime_type.name in ('List', 'Set')


def template_input(name, spec):
    default = None
    cwl_type = "File"
    if is_array(spec.qiime_type):
        cwl_type += "[]"
    if spec.has_default():
        if spec.default is None:
            cwl_type += "?"
        else:
            default = spec.default
    return {
        name: collections.OrderedDict([
            ('label', name),
            ('doc', spec.description if spec.has_description() else None),
            ('type', cwl_type)
        ])
    }


def template_parameters(name, spec):
    default = None
    suffix = ''
    qiime_type = spec.qiime_type
    if is_array(qiime_type):
        suffix = '[]'
        qiime_type = qiime_type.fields[0]

    if spec.has_default():
        if spec.default is None:
            suffix += '?'
        else:
            default = spec.default

    if qiime_type.name in CWL_MAP:
        cwl_type = CWL_MAP[qiime_type.name] + suffix
        return {
            name: {
                'type': cwl_type,
                'doc': spec.description if spec.has_description() else None,
                'default': default
            }
        }
    elif qiime_type.name == 'Metadata':
        return {
            name: {
                'type': ['File' + suffix, 'File[]' + suffix],
                'doc': spec.description if spec.has_description() else None,
            }
        }
    elif qiime_type.name == 'MetadataColumn':
        return {
            name: {
                'type': 'File',
                'doc': spec.description if spec.has_description() else None,
            },
            (name + '_column'): {
                'type': 'string',
                'doc': 'Column name to use from %r' % name,
            }
        }
    else:
        raise Exception("Unknown type: %r" % qiime_type)


def template_outputs(name, spec):
    ext = '.qzv' if spec.qiime_type.name == 'Visualization' else '.qza'
    return {
        name: {
            'type': 'File',
            'doc': spec.description if spec.has_description() else None,
            'label': name,
            'outputBinding': {'glob': name + ext}
        }
    }


def find_all_actions(plugin=None):
    pm = sdk.PluginManager()
    if plugin is not None:
        plugins = [pm.plugins[plugin]]
    else:
        plugins = pm.plugins.values()

    for plugin in plugins:
        for action in plugin.actions.values():
            yield plugin, action


def template(directory, plugin, extra_requirements_factory):
    os.makedirs(directory, exist_ok=True)
    for plugin, action in find_all_actions(plugin):
        try:
            tool = make_tool(
                plugin, action, directory, extra_requirements_factory)
            filepath = os.path.join(directory, tool['id'] + '.cwl')
            with open(filepath, 'w') as fh:
                fh.write('#!/usr/bin/env cwl-runner\n\n')
                fh.write(yaml.dump(tool, default_flow_style=False, indent=2))

            yield Status('success', filepath, "")
        except Exception as e:
            yield Status('error', repr(action), e)


def template_tools(directory, extra_requirements_factory):
    yield
