# ----------------------------------------------------------------------------
# Copyright (c) 2018-2021, QIIME 2 development team.
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


def root_structure(extra_req_factory):
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
    requirements = extra_req_factory()
    requirements.update(tool['requirements'])
    tool['requirements'] = requirements

    return tool


def make_import(extra_req_factory):
    tool = root_structure(extra_req_factory)
    tool['id'] = 'qiime2.tools.import'
    tool['label'] = 'Import data into a QIIME 2 Artifact'
    tool['arguments'] = ['tools', 'import', 'inputs.json']
    tool['inputs']['input_type'] = collections.OrderedDict([
        ('label', 'type'),
        ('doc', 'The Semantic Type to import the data as.'),
        ('type', 'string')
    ])
    tool['inputs']['input_format'] = collections.OrderedDict([
        ('label', 'input_format'),
        ('doc', 'The format the data is currently in.'),
        ('type', 'string?')
    ])
    tool['inputs']['input_data'] = collections.OrderedDict([
        ('label', 'data'),
        ('doc', 'The data to import.'),
        ('type', ['File', 'Directory'])
    ])
    tool['inputs']['output_name'] = collections.OrderedDict([
        ('label', 'output_name'),
        ('doc', 'The filename to use for the artifact.'),
        ('type', 'string?'),
        ('default', 'artifact.qza')
    ])
    tool['outputs']['artifact'] = collections.OrderedDict([
        ('label', 'artifact'),
        ('type', 'File'),
        ('outputBinding', {'glob': '$(inputs.output_name)'})
    ])

    return tool


def make_export(extra_req_factory):
    tool = root_structure(extra_req_factory)
    tool['id'] = 'qiime2.tools.export'
    tool['label'] = 'Export data from a QIIME 2 Artifact'
    tool['arguments'] = ['tools', 'export', 'inputs.json']
    tool['inputs']['input_artifact'] = collections.OrderedDict([
        ('label', 'artifact'),
        ('doc', 'The data to export.'),
        ('type', 'File')
    ])
    tool['inputs']['output_format'] = collections.OrderedDict([
        ('label', 'output_format'),
        ('doc', 'The format to export data to.'),
        ('type', 'string?')
    ])
    tool['inputs']['output_name'] = collections.OrderedDict([
        ('label', 'output_name'),
        ('doc', 'The name of the directory to write into.'),
        ('type', 'string?'),
        ('default', 'data')
    ])
    tool['outputs']['data'] = collections.OrderedDict([
        ('label', 'data'),
        ('type', ['File', 'Directory']),
        ('outputBinding', {'glob': '$(inputs.output_name)'})
    ])

    return tool


def make_tool(plugin, action, directory, extra_req_factory):
    tool = root_structure(extra_req_factory)
    tool['id'] = action.get_import_path()
    tool['label'] = action.name
    tool['doc'] = action.description
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
    elif qiime_type.to_ast()['type'] == 'union':
        type_list = []
        for member in qiime_type.to_ast()['members']:
            union_member_name = member['name']
            type_list.append(CWL_MAP[union_member_name])
        return {
            name: {
                'type': type_list,
                'doc': spec.description if spec.has_description() else None,
                'default': default,
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


def write_tool(tool, directory):
    os.makedirs(directory, exist_ok=True)
    filepath = os.path.join(directory, tool['id'] + '.cwl')
    with open(filepath, 'w') as fh:
        fh.write('#!/usr/bin/env cwl-runner\n\n')
        fh.write(yaml.dump(tool, default_flow_style=False, indent=2))

    return filepath


def template(directory, plugin, extra_req_factory):
    for plugin, action in find_all_actions(plugin):
        try:
            tool = make_tool(plugin, action, directory, extra_req_factory)
            fp = write_tool(tool, directory)
            yield Status('success', fp, "")

        except Exception as e:
            yield Status('error', repr(action), e)


def template_tools(directory, extra_req_factory):
    # QIIME 2 "tools", but they are CWL tools too after this.
    try:
        import_tool = make_import(extra_req_factory)
        fp = write_tool(import_tool, directory)
        yield Status('success', fp, "")

        export_tool = make_export(extra_req_factory)
        fp = write_tool(export_tool, directory)
        yield Status('success', fp, "")

    except Exception as e:
        yield Status('error', 'Creating QIIME 2 tool', e)
