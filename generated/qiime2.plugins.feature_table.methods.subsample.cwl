#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- subsample
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.subsample
inputs:
  axis:
    default: null
    doc: The axis to sample over. If "sample" then samples will be randomly selected
      to be retained. If "feature" then a random set of features will be selected
      to be retained.
    type: string
  subsampling_depth:
    default: null
    doc: The total number of samples or features to be randomly sampled. Samples or
      features that are reduced to a zero sum will not be included in the resulting
      table.
    type: long
  table:
    doc: The feature table to be sampled.
    label: table
    type: File
outputs:
  sampled_table:
    doc: The resulting subsampled feature table.
    label: sampled_table
    outputBinding:
      glob: sampled_table.qzv
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
