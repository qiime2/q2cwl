#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- nmit
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.methods.nmit
inputs:
  corr_method:
    default: kendall
    doc: The temporal correlation test to be applied.
    type: string
  dist_method:
    default: fro
    doc: Temporal distance method, see numpy.linalg.norm for details.
    type: string
  individual_id_column:
    default: null
    doc: Metadata column containing IDs for individual subjects.
    type: string
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  table:
    doc: Feature table to use for microbial interdependence test.
    label: table
    type: File
outputs:
  distance_matrix:
    doc: The resulting distance matrix.
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
