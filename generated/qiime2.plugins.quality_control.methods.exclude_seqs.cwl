#!/usr/bin/env cwl-runner

arguments:
- run
- quality_control
- exclude_seqs
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.quality_control.methods.exclude_seqs
inputs:
  evalue:
    default: null
    doc: BLAST expectation (E) value threshold for saving hits. Reject if E value
      is higher than threshold. This threshold is disabled by default.
    type: double?
  method:
    default: blast
    doc: Alignment method to use for matching feature sequences against reference
      sequences
    type: string
  perc_identity:
    default: 0.97
    doc: Reject match if percent identity to reference is lower. Must be in range
      [0.0, 1.0]
    type: double
  perc_query_aligned:
    default: 0.97
    doc: Percent of query sequence that must align to reference in order to be accepted
      as a hit.
    type: double
  query_sequences:
    doc: Sequences to test for exclusion
    label: query_sequences
    type: File
  reference_sequences:
    doc: Reference sequences to align against feature sequences
    label: reference_sequences
    type: File
  threads:
    default: 1
    doc: Number of jobs to execute. Only applies to vsearch method.
    type: long
outputs:
  sequence_hits:
    doc: Subset of feature sequences that align to reference sequences
    label: sequence_hits
    outputBinding:
      glob: sequence_hits.qzv
    type: File
  sequence_misses:
    doc: Subset of feature sequences that do not align to reference sequences
    label: sequence_misses
    outputBinding:
      glob: sequence_misses.qzv
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
