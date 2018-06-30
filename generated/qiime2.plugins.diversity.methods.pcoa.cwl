#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- pcoa
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.pcoa
inputs:
  distance_matrix:
    doc: The distance matrix on which PCoA should be computed.
    label: distance_matrix
    type: File
outputs:
  pcoa:
    doc: The resulting PCoA matrix.
    label: pcoa
    outputBinding:
      glob: pcoa.qzv
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
