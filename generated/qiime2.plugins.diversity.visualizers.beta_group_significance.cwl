#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- beta_group_significance
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.visualizers.beta_group_significance
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    label: distance_matrix
    type: File
  metadata:
    doc: Categorical sample metadata column.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  method:
    default: permanova
    doc: The group significance test to be applied.
    type: string
  pairwise:
    default: false
    doc: Perform pairwise tests between all pairs of groups in addition to the test
      across all groups. This can be very slow if there are a lot of groups in the
      metadata column.
    type: boolean
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values.
    type: long
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
