#!/usr/bin/env cwl-runner

arguments:
- run
- metadata
- distance_matrix
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.metadata.methods.distance_matrix
inputs:
  metadata:
    doc: Numeric metadata column to compute pairwise Euclidean distances from
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
outputs:
  distance_matrix:
    doc: null
    label: distance_matrix
    outputBinding:
      glob: distance_matrix.qzv
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
