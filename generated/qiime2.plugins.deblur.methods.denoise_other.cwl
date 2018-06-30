#!/usr/bin/env cwl-runner

arguments:
- run
- deblur
- denoise_other
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.deblur.methods.denoise_other
inputs:
  demultiplexed_seqs:
    doc: The demultiplexed sequences to be denoised.
    label: demultiplexed_seqs
    type: File
  hashed_feature_ids:
    default: true
    doc: If true, hash the feature IDs.
    type: boolean
  indel_max:
    default: 3
    doc: Maximum number of insertion/deletions.
    type: long
  indel_prob:
    default: 0.01
    doc: Insertion/deletion (indel) probability (same for N indels).
    type: double
  jobs_to_start:
    default: 1
    doc: Number of jobs to start (if to run in parallel).
    type: long
  mean_error:
    default: 0.005
    doc: The mean per nucleotide error, used for original sequence estimate.
    type: double
  min_reads:
    default: 10
    doc: Retain only features appearing at least min_reads times across all samples
      in the resulting feature table.
    type: long
  min_size:
    default: 2
    doc: In each sample, discard all features with an abundance less than min_size.
    type: long
  reference_seqs:
    doc: Positive filtering database. Keep all sequences aligning to these sequences.
    label: reference_seqs
    type: File
  sample_stats:
    default: false
    doc: If true, gather stats per sample.
    type: boolean
  trim_length:
    default: null
    doc: Sequence trim length, specify -1 to disable trimming.
    type: long
outputs:
  representative_sequences:
    doc: The resulting feature sequences.
    label: representative_sequences
    outputBinding:
      glob: representative_sequences.qzv
    type: File
  stats:
    doc: Per-sample stats if requested.
    label: stats
    outputBinding:
      glob: stats.qzv
    type: File
  table:
    doc: The resulting denoised feature table.
    label: table
    outputBinding:
      glob: table.qzv
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
