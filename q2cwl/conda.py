# ----------------------------------------------------------------------------
# Copyright (c) 2018-2021, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

import collections
import subprocess
import locale
import json
import io

import q2cwl.template as template


def conda_list():
    results = subprocess.run(['conda', 'list', '--json'],
                             stdout=subprocess.PIPE, check=True)
    return json.load(io.TextIOWrapper(io.BytesIO(results.stdout)))


def format_software_package(dep):
    r = collections.OrderedDict()
    r['package'] = dep['name']
    r['version'] = [dep['version']]
    r['specs'] = [
        '/'.join(['https://ananconda.org',  dep['channel'], dep['name']])]
    return r


def run_conda_cmd(output_dir: str, include_tools: bool = True,
                  plugin: str = None):
    packages = list(map(format_software_package, conda_list()))

    def make_requirements():
        req = collections.OrderedDict()
        req['EnvVarRequirement'] = {
            'envDef': {
                'MPLBACKEND': 'Agg',
                'LC_ALL': '.'.join([locale.getlocale()[0], 'UTF-8'])
            }
        }

        # TODO: I can't seem to get this part to work right. I get:
        #  Unsupported requirement SoftwareRequirement
        # from cwltool and cwlrunner even with cwltool[dep] and the
        # --beta-conda-dependencies flag.

        # req['SoftwareRequirement'] = {
        #     'packages': packages
        # }

        return req

    yield from template.template(output_dir, plugin, make_requirements)
    if include_tools:
        yield from template.template_tools(output_dir, make_requirements)
