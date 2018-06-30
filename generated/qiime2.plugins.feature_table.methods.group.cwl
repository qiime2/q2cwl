#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- group
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.group
inputs:
  axis:
    default: null
    doc: Along which axis to group. Each ID in the given axis must exist in `metadata`.
    type: string
  metadata:
    doc: A column defining the groups. Each unique value will become a new ID for
      the table on the given `axis`.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  mode:
    default: null
    doc: How to combine samples or features within a group. `sum` will sum the frequencies
      across all samples or features within a group; `mean-ceiling` will take the
      ceiling of the mean of these frequencies; `median-ceiling` will take the ceiling
      of the median of these frequencies.
    type: string
  table:
    doc: The table to group samples or features on.
    label: table
    type: File
outputs:
  grouped_table:
    doc: A table that has been grouped along the given `axis`. IDs on that axis are
      replaced by values in the `metadata` column.
    label: grouped_table
    outputBinding:
      glob: grouped_table.qzv
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
