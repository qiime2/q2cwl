# ----------------------------------------------------------------------------
# Copyright (c) 2018-2021, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

import os
import json
import distutils

import qiime2
import qiime2.sdk as sdk


def run_runner_cmd(plugin, action, inputs_json):
    with open(inputs_json, 'r') as fh:
        inputs = json.load(fh)['inputs']

    if plugin == 'tools':
        # Not actually a plugin then, use the SDK
        if action == 'import':
            return _import(inputs)
        elif action == 'export':
            return _export(inputs)
        else:
            raise Exception('Unkown command: %r' % action)
    else:
        return _execute(plugin, action, inputs)


def _import(inputs):
    a = qiime2.Artifact.import_data(
            inputs['input_type'], inputs['input_data']['path'],
            view_type=inputs['input_format'])
    a.save(inputs['output_name'])


def _export(inputs):
    a = qiime2.Artifact.load(inputs['input_artifact']['path'])
    fmt = a.format
    if inputs['output_format'] is not None:
        fmt = sdk.parse_format(inputs['output_format'])

    output_path = inputs['output_name']
    result = a.view(fmt)

    if os.path.isfile(str(result)):
        os.renames(str(result), output_path)
    else:
        os.makedirs(output_path, exist_ok=True)
        distutils.dir_util.copy_tree(str(result), output_path)


def _iter_provided(available, provided):
    for name, spec in available.items():
        if name in provided:
            yield name, spec


def _handle_metadata(inputs):
    if isinstance(inputs, list):
        to_merge = [_load_metadata(entry['path']) for entry in inputs]
    else:
        to_merge = [_load_metadata(inputs['path'])]

    if len(to_merge) == 1:
        return to_merge[0]
    else:
        return to_merge[0].merge(*to_merge[1:])


def _load_metadata(fp):
    try:
        artifact = qiime2.Artifact.load(fp)
    except Exception:
        metadata = qiime2.Metadata.load(fp)
    else:
        metadata = artifact.view(qiime2.Metadata)

    return metadata


def _execute(plugin, action, inputs):
    pm = sdk.PluginManager()
    action = pm.plugins[plugin.replace('_', '-')].actions[action]
    signature = action.signature

    kwargs = {}
    for name, spec in _iter_provided(signature.inputs, inputs):
        if inputs[name] is None:
            continue
        if spec.qiime_type.name in ('List', 'Set'):
            kwargs[name] = [sdk.Artifact.load(v['path']) for v in inputs[name]]
            if spec.qiime_type.name == 'Set':
                kwargs[name] = set(kwargs[name])
        else:
            kwargs[name] = sdk.Artifact.load(inputs[name]['path'])

    for name, spec in _iter_provided(signature.parameters, inputs):
        if inputs[name] is None:
            continue
        if spec.qiime_type.name == 'Set':
            kwargs[name] = set(kwargs[name])
        elif spec.qiime_type.name == 'Metadata':
            kwargs[name] = _handle_metadata(inputs[name])
        elif spec.qiime_type.name == 'MetadataColumn':
            md = _handle_metadata(inputs[name])
            kwargs[name] = md.get_column(inputs[name + '_column'])
        else:
            kwargs[name] = inputs[name]

    results = action(**kwargs)

    for name, result in zip(results._fields, results):
        result.save(name)
