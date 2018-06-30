import json

import click
import qiime2.sdk as sdk

from q2cwl.install import template_all

@click.group()
def root():
    pass

@root.command()
@click.argument('directory', type=click.Path(dir_okay=True, file_okay=False))
def install(directory):
    template_all(directory)


def _resolve(value):
    if isinstance(value, list):
        return [_resolve(v) for v in value]
    if isinstance(value, dict) and value['class'] == 'File':
        return sdk.Artifact.load(value['path'])
    else:
        return value

@root.command()
@click.argument('plugin', type=str)
@click.argument('action', type=str)
@click.argument('inputs', type=click.Path(file_okay=True, dir_okay=False,
                                        exists=True))
def run(plugin, action, inputs):
    with open(inputs, 'r') as fh:
        inputs = json.load(fh)['_'] # junk outer wrapper from templating
    pm = sdk.PluginManager()
    action = pm.plugins[plugin.replace('_', '-')].actions[action]
    signature = action.signature

    kwargs = {}
    for name, spec in _iter_provided(signature.inputs, inputs):
        if spec.qiime_type.name in ('List', 'Set'):
            kwargs[name] = [sdk.Artifact.load(v['path']) for v in inputs[name]]
            if spec.qiime_type.name == 'Set':
                kwargs[name] = set(kwargs[name])
        else:
            kwargs[name] = sdk.Artifact.load(inputs[name]['path'])

    for name, spec in _iter_provided(signature.parameters, inputs):
        if spec.qiime_type.name == 'Set':
            kwargs[name] = set(kwargs[name])
        elif spec.qiime_type.name == 'Metadata':
            kwargs[name] = qiime2.Metadata.load(inputs[name]['path'])
        elif spec.qiime_type.name == 'MetadataColumn':
            kwargs[name] = qiime2.MetadataColumn.load(inputs[name]['path'], inputs[name + "_column"])
        else:
            kwargs[name] = inputs[name]

    results = action(**kwargs)

    for name, result in zip(results._fields, results):
        result.save(name)


def _iter_provided(available, provided):
    for name, spec in available.items():
        if name in provided:
            yield name, spec
