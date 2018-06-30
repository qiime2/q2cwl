#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- volatility
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.visualizers.volatility
inputs:
  default_group_column:
    default: null
    doc: The default metadata column on which to separate groups for comparison (all
      categorical metadata columns will be available in the visualization).
    type: string?
  default_metric:
    default: null
    doc: Numeric metadata or artifact column to test by default (all numeric metadata
      columns will be available in the visualization).
    type: string?
  individual_id_column:
    default: null
    doc: Metadata column containing IDs for individual subjects.
    type: string
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  state_column:
    default: null
    doc: Metadata column containing state (e.g., Time) across which samples are paired.
    type: string
  table:
    doc: Feature table to optionally use for paired comparisons.
    label: table
    type: File?
  yscale:
    default: linear
    doc: y-axis scaling strategy to apply.
    type: string
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
