#!/usr/bin/env cwl-runner

arguments:
- run
- feature_classifier
- classify_sklearn
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_classifier.methods.classify_sklearn
inputs:
  classifier:
    doc: The taxonomic classifier for classifying the reads.
    label: classifier
    type: File
  confidence:
    default: 0.7
    doc: Confidence threshold for limiting taxonomic depth. Provide -1 to disable
      confidence calculation, or 0 to calculate confidence but not apply it to limit
      the taxonomic depth of the assignments.
    type: double
  n_jobs:
    default: 1
    doc: The maximum number of concurrently worker processes. If -1 all CPUs are used.
      If 1 is given, no parallel computing code is used at all, which is useful for
      debugging. For n_jobs below -1, (n_cpus + 1 + n_jobs) are used. Thus for n_jobs
      = -2, all CPUs but one are used.
    type: long
  pre_dispatch:
    default: 2*n_jobs
    doc: '"all" or expression, as in "3*n_jobs". The number of batches (of tasks)
      to be pre-dispatched.'
    type: string
  read_orientation:
    default: null
    doc: Direction of reads with respect to reference sequences. same will cause reads
      to be classified unchanged; reverse-complement will cause reads to be reversed
      and complemented prior to classification. Default is to autodetect based on
      the confidence estimates for the first 100 reads.
    type: string?
  reads:
    doc: The feature data to be classified.
    label: reads
    type: File
  reads_per_batch:
    default: 0
    doc: Number of reads to process in each batch. If 0, this parameter is autoscaled
      to the number of query sequences / n_jobs.
    type: long
outputs:
  classification:
    doc: null
    label: classification
    outputBinding:
      glob: classification.qzv
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
