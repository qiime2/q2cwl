#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- rarefy
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.rarefy
inputs:
  sampling_depth:
    default: null
    doc: The total frequency that each sample should be rarefied to. Samples where
      the sum of frequencies is less than the sampling depth will be not be included
      in the resulting table.
    type: long
  table:
    doc: The feature table to be rarefied.
    label: table
    type: File
outputs:
  rarefied_table:
    doc: The resulting rarefied feature table.
    label: rarefied_table
    outputBinding:
      glob: rarefied_table.qzv
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
