#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- summarize
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.visualizers.summarize
inputs:
  sample_metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  table:
    doc: The feature table to be summarized.
    label: table
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
