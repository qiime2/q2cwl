#!/usr/bin/env cwl-runner

arguments:
- run
- cutadapt
- demux_single
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.cutadapt.methods.demux_single
inputs:
  barcodes:
    doc: The sample metadata column listing the per-sample barcodes.
    type: File
  barcodes_column:
    doc: Column name to use from 'barcodes'
    type: string
  error_rate:
    default: 0.1
    doc: The level of error tolerance, specified as the maximum allowable error rate.
      The default value specified by cutadapt is 0.1 (=10%), which is greater than
      `demux emp-*`, which is 0.0 (=0%).
    type: double
  seqs:
    doc: The single-end sequences to be demultiplexed.
    label: seqs
    type: File
outputs:
  per_sample_sequences:
    doc: The resulting demultiplexed sequences.
    label: per_sample_sequences
    outputBinding:
      glob: per_sample_sequences.qzv
    type: File
  untrimmed_sequences:
    doc: The sequences that were unmatched to barcodes.
    label: untrimmed_sequences
    outputBinding:
      glob: untrimmed_sequences.qzv
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
