# ----------------------------------------------------------------------------
# Copyright (c) 2018-2021, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

import sys
import json
import traceback as tb

import click
import qiime2.sdk as sdk

import q2cwl


def echo_status(status: 'Status', quiet: bool = False):
    if status is None:
        return

    if status.status == 'success' and not quiet:
        click.secho(status.action + " : created successfully.",
                    fg='green', bold=True)
    elif status.status == 'error':
        e = status.message
        tb.print_exception(type(e), e, e.__traceback__, file=sys.stderr)
        sys.stderr.write('\n')

        click.secho(status.action + " : " + str(status.message),
                    fg='red', bold=True)
        click.echo("")
        click.echo("See above for error details.")
        click.get_current_context().exit(2)


@click.group()
@click.version_option(q2cwl.__version__)
def templater():
    pass


@templater.group(short_help="Template CWL Tool descriptions from available"
                 " actions")
def template():
    pass


@template.command(short_help="For use within a Conda environment")
@click.option('--plugin', required=False, help='Template only a single plugin')
@click.option('--tools/--no-tools', default=True, help='Include QIIME 2 tools')
@click.option('--quiet/--no-quiet', default=False)
@click.argument('output-dir', type=click.Path(file_okay=False, writable=True))
def conda(output_dir: str, tools: bool = True, plugin: str = None,
          quiet: bool = False):
    for status in q2cwl.run_conda_cmd(output_dir, tools, plugin):
        echo_status(status, quiet)


@template.command(short_help="For use within a Docker container")
@click.option('--tools/--no-tools', default=True, help='Include QIIME 2 tools')
@click.option('--remote', 'availability', flag_value='remote', default=True,
              help='Image is available on hub.docker.com (default)')
@click.option('--local', 'availability', flag_value='local',
              help='Image is only available on current host.')
@click.option('--quiet/--no-quiet', default=False)
@click.argument('image-id')
def docker(image_id: str, tools: bool = True, availability: str = 'remote',
           quiet: bool = False):
    for status in q2cwl.run_docker_cmd(image_id, tools, availability):
        echo_status(status, quiet)


@click.command(help="Do not use directly, used internally by q2cwl.")
@click.argument('plugin', type=str)
@click.argument('action', type=str)
@click.argument('inputs-json',
                type=click.Path(file_okay=True, dir_okay=False, exists=True))
def runner(plugin, action, inputs_json):
    q2cwl.run_runner_cmd(plugin, action, inputs_json)
