#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- filter_distance_matrix
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.filter_distance_matrix
inputs:
  distance_matrix:
    doc: Distance matrix to filter by sample.
    label: distance_matrix
    type: File
  exclude_ids:
    default: false
    doc: If `True`, the samples selected by `metadata` or `where` parameters will
      be excluded from the filtered distance matrix instead of being retained.
    type: boolean
  metadata:
    doc: Sample metadata used with `where` parameter when selecting samples to retain,
      or with `exclude_ids` when selecting samples to discard.
    type:
    - File
    - File[]
  where:
    default: null
    doc: SQLite WHERE clause specifying sample metadata criteria that must be met
      to be included in the filtered distance matrix. If not provided, all samples
      in `metadata` that are also in the input distance matrix will be retained.
    type: string?
outputs:
  filtered_distance_matrix:
    doc: Distance matrix filtered to include samples matching search criteria
    label: filtered_distance_matrix
    outputBinding:
      glob: filtered_distance_matrix.qzv
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
