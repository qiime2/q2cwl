#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- filter_samples
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.filter_samples
inputs:
  exclude_ids:
    default: false
    doc: If true, the samples selected by `metadata` or `where` parameters will be
      excluded from the filtered table instead of being retained.
    type: boolean
  max_features:
    default: null
    doc: The maximum number of features that a sample can have to be retained. If
      no value is provided this will default to infinity (i.e., no maximum feature
      filter will be applied).
    type: long?
  max_frequency:
    default: null
    doc: The maximum total frequency that a sample can have to be retained. If no
      value is provided this will default to infinity (i.e., no maximum frequency
      filter will be applied).
    type: long?
  metadata:
    doc: Sample metadata used with `where` parameter when selecting samples to retain,
      or with `exclude_ids` when selecting samples to discard.
    type:
    - File?
    - File[]?
  min_features:
    default: 0
    doc: The minimum number of features that a sample must have to be retained.
    type: long
  min_frequency:
    default: 0
    doc: The minimum total frequency that a sample must have to be retained.
    type: long
  table:
    doc: The feature table from which samples should be filtered.
    label: table
    type: File
  where:
    default: null
    doc: SQLite WHERE clause specifying sample metadata criteria that must be met
      to be included in the filtered feature table. If not provided, all samples in
      `metadata` that are also in the feature table will be retained.
    type: string?
outputs:
  filtered_table:
    doc: The resulting feature table filtered by sample.
    label: filtered_table
    outputBinding:
      glob: filtered_table.qzv
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
