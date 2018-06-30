#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- bioenv
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.visualizers.bioenv
inputs:
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    label: distance_matrix
    type: File
  metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
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
