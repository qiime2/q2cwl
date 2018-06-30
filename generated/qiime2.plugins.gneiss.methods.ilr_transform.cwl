#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- ilr_transform
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.methods.ilr_transform
inputs:
  table:
    doc: The feature table containing the samples in which the ilr transform will
      be performed.
    label: table
    type: File
  tree:
    doc: A hierarchy of feature identifiers that defines the partitions of features.  Each
      tip in the hierarchycorresponds to the feature identifiers in the table. This
      tree can contain tip ids that are not present in the table, but all feature
      ids in the table must be present in this tree.  This assumes that all of the
      internal nodes in the tree have labels.
    label: tree
    type: File
outputs:
  balances:
    doc: The resulting balances from the ilr transform.
    label: balances
    outputBinding:
      glob: balances.qzv
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
