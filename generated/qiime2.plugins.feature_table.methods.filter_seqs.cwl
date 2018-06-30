#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- filter_seqs
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.filter_seqs
inputs:
  data:
    doc: The sequences from which features should be filtered.
    label: data
    type: File
  exclude_ids:
    default: false
    doc: If true, the features selected by the `metadata` (with or without the `where`
      parameter) or `table` parameter will be excluded from the filtered sequences
      instead of being retained.
    type: boolean
  metadata:
    doc: Feature metadata used for id-based filtering, with `where` parameter when
      selecting features to retain, or with `exclude_ids` when selecting features
      to discard.
    type:
    - File?
    - File[]?
  table:
    doc: Table containing feature ids used for id-based filtering.
    label: table
    type: File?
  where:
    default: null
    doc: SQLite WHERE clause specifying feature metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all features
      in `metadata` that are also in the sequences will be retained.
    type: string?
outputs:
  filtered_data:
    doc: The resulting filtered sequences.
    label: filtered_data
    outputBinding:
      glob: filtered_data.qzv
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
