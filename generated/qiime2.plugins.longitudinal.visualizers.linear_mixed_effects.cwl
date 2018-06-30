#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- linear_mixed_effects
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.visualizers.linear_mixed_effects
inputs:
  ci:
    default: 95
    doc: Size of the confidence interval for the regression estimate.
    type: double
  group_columns:
    default: null
    doc: Comma-separated list (without spaces) of metadata columns to use as independent
      covariates used to determine mean structure of "metric".
    type: string?
  individual_id_column:
    default: null
    doc: Metadata column containing IDs for individual subjects.
    type: string
  lowess:
    default: false
    doc: Estimate locally weighted scatterplot smoothing. Note that this will eliminate
      confidence interval plotting.
    type: boolean
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  metric:
    default: null
    doc: Dependent variable column name. Must be a column name located in the metadata
      or feature table files.
    type: string
  palette:
    default: Set1
    doc: Color palette to use for generating boxplots.
    type: string
  random_effects:
    default: null
    doc: Comma-separated list (without spaces) of metadata columns to use as independent
      covariates used to determine the variance and covariance structure (random effects)
      of "metric". To add a random slope, the same value passed to "state_column"
      should be passed here. A random intercept for each individual is set by default
      and does not need to be passed here.
    type: string?
  state_column:
    default: null
    doc: Metadata column containing state (e.g., Time) across which samples are paired.
    type: string
  table:
    doc: Feature table to optionally use for paired comparisons.
    label: table
    type: File?
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
