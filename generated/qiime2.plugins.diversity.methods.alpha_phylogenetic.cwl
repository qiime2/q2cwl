#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- alpha_phylogenetic
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.alpha_phylogenetic
inputs:
  metric:
    default: null
    doc: The alpha diversity metric to be computed.
    type: string
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    label: phylogeny
    type: File
  table:
    doc: The feature table containing the samples for which alpha diversity should
      be computed.
    label: table
    type: File
outputs:
  alpha_diversity:
    doc: Vector containing per-sample alpha diversities.
    label: alpha_diversity
    outputBinding:
      glob: alpha_diversity.qzv
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
