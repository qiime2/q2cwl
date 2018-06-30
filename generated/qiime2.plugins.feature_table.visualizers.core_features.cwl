#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- core_features
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.visualizers.core_features
inputs:
  max_fraction:
    default: 1.0
    doc: The maximum fraction of samples that a feature must be observed in for that
      feature to be considered a core feature.
    type: double
  min_fraction:
    default: 0.5
    doc: The minimum fraction of samples that a feature must be observed in for that
      feature to be considered a core feature.
    type: double
  steps:
    default: 11
    doc: The number of steps to take between `min_fraction` and `max_fraction` for
      core features calculations. This parameter has no effect if `min_fraction` and
      `max_fraction` are the same value.
    type: long
  table:
    doc: The feature table to use in core features calculations.
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
