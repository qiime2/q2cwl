#!/usr/bin/env cwl-runner

arguments:
- run
- deblur
- visualize_stats
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.deblur.visualizers.visualize_stats
inputs:
  deblur_stats:
    doc: Summary statistics of the Deblur process.
    label: deblur_stats
    type: File
outputs:
  visualization:
    doc: null
    label: visualization
    outputBinding:
      glob: visualization.qzv
    type: File
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.utf8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entry: '{"_": $(inputs)}'
      entryname: inputs.json
