#!/usr/bin/env cwl-runner

arguments:
- run
- phylogeny
- midpoint_root
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.phylogeny.methods.midpoint_root
inputs:
  tree:
    doc: The phylogenetic tree to be rooted.
    label: tree
    type: File
outputs:
  rooted_tree:
    doc: The rooted phylogenetic tree.
    label: rooted_tree
    outputBinding:
      glob: rooted_tree.qzv
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
