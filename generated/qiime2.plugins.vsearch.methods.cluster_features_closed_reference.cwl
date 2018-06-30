#!/usr/bin/env cwl-runner

arguments:
- run
- vsearch
- cluster_features_closed_reference
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.vsearch.methods.cluster_features_closed_reference
inputs:
  perc_identity:
    default: null
    doc: The percent identity at which clustering should be performed. This parameter
      maps to vsearch's --id parameter.
    type: double
  reference_sequences:
    doc: The sequences to use as cluster centroids.
    label: reference_sequences
    type: File
  sequences:
    doc: The sequences corresponding to the features in table.
    label: sequences
    type: File
  strand:
    default: plus
    doc: Search plus (i.e., forward) or both (i.e., forward and reverse complement)
      strands.
    type: string
  table:
    doc: The feature table to be clustered.
    label: table
    type: File
  threads:
    default: 1
    doc: The number of threads to use for computation. Passing 0 will launch one thread
      per CPU core.
    type: long
outputs:
  clustered_sequences:
    doc: The sequences representing clustered features, relabeled by the reference
      IDs.
    label: clustered_sequences
    outputBinding:
      glob: clustered_sequences.qzv
    type: File
  clustered_table:
    doc: The table following clustering of features.
    label: clustered_table
    outputBinding:
      glob: clustered_table.qzv
    type: File
  unmatched_sequences:
    doc: The sequences which failed to match any reference sequences. This output
      maps to vsearch's --notmatched parameter.
    label: unmatched_sequences
    outputBinding:
      glob: unmatched_sequences.qzv
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
