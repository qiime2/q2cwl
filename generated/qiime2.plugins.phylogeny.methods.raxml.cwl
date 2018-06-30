#!/usr/bin/env cwl-runner

arguments:
- run
- phylogeny
- raxml
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.phylogeny.methods.raxml
inputs:
  alignment:
    doc: Aligned sequences to be used for phylogenetic reconstruction.
    label: alignment
    type: File
  n_searches:
    default: 1
    doc: The number of independent maximum likelihood searches to perform. The single
      best scoring tree is returned.
    type: long
  n_threads:
    default: 1
    doc: The number of threads to use for multithreaded processing. Using more than
      one thread will enable the PTHREADS version of RAxML.
    type: long
  seed:
    default: null
    doc: Random number seed for the parsimony starting tree. This allows you to reproduce
      tree results. If not supplied then one will be randomly chosen.
    type: long?
  substitution_model:
    default: GTRGAMMA
    doc: Model of Nucleotide Substitution.
    type: string
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
