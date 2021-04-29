# ----------------------------------------------------------------------------
# Copyright (c) 2018-2021, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

import collections

import q2cwl.template as template


def run_docker_cmd(image_id: str, include_tools: bool = True,
                   availability: str = 'remote'):
    def make_requirements():
        r = collections.OrderedDict()
        if availability == 'remote':
            r['dockerPull'] = image_id
        r['dockerImageId'] = image_id
        r['dockerOutputDirectory'] = '/home/qiime2'

        return {'DockerRequirement': r}

    output_dir = '/tmp/cwl-tools/'
    yield from template.template(output_dir, None, make_requirements)
    if include_tools:
        yield from template.template_tools(output_dir, make_requirements)
