#!/usr/bin/env cwl-runner

arguments:
- run
- phylogeny
- fasttree
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.phylogeny.methods.fasttree
inputs:
  alignment:
    doc: Aligned sequences to be used for phylogenetic reconstruction.
    label: alignment
    type: File
  n_threads:
    default: 1
    doc: The number of threads. Using more than one thread runs the non-deterministic
      variant of `FastTree` (`FastTreeMP`), and may result in a different tree than
      single-threading. See http://www.microbesonline.org/fasttree/#OpenMP for details.
      (Use -1 to automatically use all available cores)
    type: long
outputs:
  tree:
    doc: The resulting phylogenetic tree.
    label: tree
    outputBinding:
      glob: tree.qzv
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
