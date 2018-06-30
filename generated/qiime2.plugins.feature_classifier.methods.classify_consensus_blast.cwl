#!/usr/bin/env cwl-runner

arguments:
- run
- feature_classifier
- classify_consensus_blast
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_classifier.methods.classify_consensus_blast
inputs:
  evalue:
    default: 0.001
    doc: BLAST expectation value (E) threshold for saving hits.
    type: double
  maxaccepts:
    default: 10
    doc: Maximum number of hits to keep for each query. Must be in range [0, infinity].
    type: long
  min_consensus:
    default: 0.51
    doc: Minimum fraction of assignments must match top hit to be accepted as consensus
      assignment. Must be in range (0.5, 1.0].
    type: double
  perc_identity:
    default: 0.8
    doc: Reject match if percent identity to query is lower. Must be in range [0.0,
      1.0].
    type: double
  query:
    doc: Sequences to classify taxonomically.
    label: query
    type: File
  reference_reads:
    doc: reference sequences.
    label: reference_reads
    type: File
  reference_taxonomy:
    doc: reference taxonomy labels.
    label: reference_taxonomy
    type: File
  strand:
    default: both
    doc: Align against reference sequences in forward ("plus"), reverse ("minus"),
      or both directions ("both").
    type: string
  unassignable_label:
    default: Unassigned
    doc: null
    type: string
outputs:
  classification:
    doc: Taxonomy classifications of query sequences.
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
