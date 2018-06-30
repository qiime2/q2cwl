#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- merge
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.merge
inputs:
  overlap_method:
    default: error_on_overlapping_sample
    doc: Method for handling overlapping ids.
    type: string
  tables:
    doc: The collection of feature tables to be merged.
    label: tables
    type: File[]
outputs:
  merged_table:
    doc: The resulting merged feature table.
    label: merged_table
    outputBinding:
      glob: merged_table.qzv
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
