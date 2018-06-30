#!/usr/bin/env cwl-runner

arguments:
- run
- vsearch
- join_pairs
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.vsearch.methods.join_pairs
inputs:
  allowmergestagger:
    default: false
    doc: Allow joining of staggered read pairs.
    type: boolean
  demultiplexed_seqs:
    doc: The demultiplexed paired-end sequences to be joined.
    label: demultiplexed_seqs
    type: File
  maxdiffs:
    default: 10
    doc: Maximum number of mismatches in the forward/reverse read overlap for joining.
    type: long
  maxee:
    default: null
    doc: Maximum number of expected errors in the joined read to be retained.
    type: double?
  maxmergelen:
    default: null
    doc: Maximum length of the joined read to be retained.
    type: long?
  maxns:
    default: null
    doc: Sequences with more than maxns N characters are discarded.
    type: long?
  minlen:
    default: 1
    doc: Sequences shorter than minlen after truncation are discarded.
    type: long
  minmergelen:
    default: null
    doc: Minimum length of the joined read to be retained.
    type: long?
  minovlen:
    default: 10
    doc: Minimum overlap length of forward and reverse reads for joining.
    type: long
  qmax:
    default: 41
    doc: The maximum allowed quality score in the input.
    type: long
  qmaxout:
    default: 41
    doc: The maximum allowed quality score to use in output.
    type: long
  qmin:
    default: 0
    doc: The minimum allowed quality score in the input.
    type: long
  qminout:
    default: 0
    doc: The minimum allowed quality score to use in output.
    type: long
  truncqual:
    default: null
    doc: Truncate sequences at the first base with the specified quality score value
      or lower.
    type: long?
outputs:
  joined_sequences:
    doc: The joined sequences.
    label: joined_sequences
    outputBinding:
      glob: joined_sequences.qzv
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
