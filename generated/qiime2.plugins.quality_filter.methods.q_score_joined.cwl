#!/usr/bin/env cwl-runner

arguments:
- run
- quality_filter
- q_score_joined
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.quality_filter.methods.q_score_joined
inputs:
  demux:
    doc: The demultiplexed sequence data to be quality filtered.
    label: demux
    type: File
  max_ambiguous:
    default: 0
    doc: The maximum number of ambiguous (i.e., N) base calls. This is applied after
      trimming sequences based on `min_length_fraction`.
    type: long
  min_length_fraction:
    default: 0.75
    doc: The minimum length that a sequence read can be following truncation and still
      be retained. This length should be provided as a fraction of the input sequence
      length.
    type: double
  min_quality:
    default: 4
    doc: The minimum acceptable PHRED score. All PHRED scores less that this value
      are considered to be low PHRED scores.
    type: long
  quality_window:
    default: 3
    doc: The maximum number of low PHRED scores that can be observed in direct succession
      before truncating a sequence read.
    type: long
outputs:
  filter_stats:
    doc: Summary statistics of the filtering process.
    label: filter_stats
    outputBinding:
      glob: filter_stats.qzv
    type: File
  filtered_sequences:
    doc: The resulting quality-filtered sequences.
    label: filtered_sequences
    outputBinding:
      glob: filtered_sequences.qzv
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
