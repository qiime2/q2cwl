#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- beta
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.beta
inputs:
  metric:
    default: null
    doc: The beta diversity metric to be computed.
    type: string
  n_jobs:
    default: 1
    doc: The number of jobs to use for the computation. This works by breaking down
      the pairwise matrix into n_jobs even slices and computing them in parallel.
      If -1 all CPUs are used. If 1 is given, no parallel computing code is used at
      all, which is useful for debugging. For n_jobs below -1, (n_cpus + 1 + n_jobs)
      are used. Thus for n_jobs = -2, all CPUs but one are used. (Description from
      sklearn.metrics.pairwise_distances)
    type: long
  table:
    doc: The feature table containing the samples over which beta diversity should
      be computed.
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
