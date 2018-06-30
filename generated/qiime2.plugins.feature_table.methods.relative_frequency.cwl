#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- relative_frequency
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.relative_frequency
inputs:
  table:
    doc: The feature table to be converted into relative frequencies.
    label: table
    type: File
outputs:
  relative_frequency_table:
    doc: The resulting relative frequency feature table.
    label: relative_frequency_table
    outputBinding:
      glob: relative_frequency_table.qzv
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
