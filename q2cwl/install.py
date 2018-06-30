import os

import yaml

import qiime2.sdk as sdk

CWL_MAP = {
    'Str': 'string',
    'Int': 'long',
    'Bool': 'boolean',
    'Float': 'double',
    'Color': 'string',
}


ROOT = {
    'cwlVersion': 'v1.0',
    'class': 'CommandLineTool',
    'baseCommand': 'q2cwl',
    'requirements': {
        'InitialWorkDirRequirement': {
            'listing': [
                {
                    'entryname': 'inputs.json',
                    'entry': '{"_": $(inputs)}'
                }
            ]
        },
        'EnvVarRequirement': {
            'envDef': {
                'MPLBACKEND': 'Agg',
                'LC_ALL': 'en_US.utf8'
            }
        }
    }
}


def make_tool(plugin, action, directory):
    tool = {'id': action.get_import_path(), **ROOT}
    tool['inputs'] = {}
    tool['outputs'] = {}
    tool['arguments'] = [
        'run', plugin.name.replace('-', '_'), action.id, 'inputs.json']

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
        name: {
            'type': cwl_type,
            'doc': spec.description if spec.has_description() else None,
            'label': name
        }
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
    return {
        name: {
            'type': 'File',
            'doc': spec.description if spec.has_description() else None,
            'label': name,
            'outputBinding': {'glob': name + '.qzv'}
        }
    }


def find_all_actions():
    pm = sdk.PluginManager()
    for plugin in pm.plugins.values():
        for action in plugin.actions.values():
            yield plugin, action


def template_all(directory):
    os.makedirs(directory, exist_ok=True)
    for plugin, action in find_all_actions():
        tool = make_tool(plugin, action, directory)
        with open(os.path.join(directory, tool['id'] + '.cwl'), 'w') as fh:
            fh.write('#!/usr/bin/env cwl-runner\n\n')
            fh.write(yaml.safe_dump(tool, default_flow_style=False, indent=2))
