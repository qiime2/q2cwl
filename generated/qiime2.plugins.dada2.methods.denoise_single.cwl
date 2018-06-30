#!/usr/bin/env cwl-runner

arguments:
- run
- dada2
- denoise_single
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.dada2.methods.denoise_single
inputs:
  chimera_method:
    default: consensus
    doc: 'The method used to remove chimeras. "none": No chimera removal is performed.
      "pooled": All reads are pooled prior to chimera detection. "consensus": Chimeras
      are detected in samples individually, and sequences found chimeric in a sufficient
      fraction of samples are removed.'
    type: string
  demultiplexed_seqs:
    doc: The single-end demultiplexed sequences to be denoised.
    label: demultiplexed_seqs
    type: File
  hashed_feature_ids:
    default: true
    doc: If true, the feature ids in the resulting table will be presented as hashes
      of the sequences defining each feature. The hash will always be the same for
      the same sequence so this allows feature tables to be merged across runs of
      this method. You should only merge tables if the exact same parameters are used
      for each run.
    type: boolean
  max_ee:
    default: 2.0
    doc: Reads with number of expected errors higher than this value will be discarded.
    type: double
  min_fold_parent_over_abundance:
    default: 1.0
    doc: The minimum abundance of potential parents of a sequence being tested as
      chimeric, expressed as a fold-change versus the abundance of the sequence being
      tested. Values should be greater than or equal to 1 (i.e. parents should be
      more abundant than the sequence being tested). This parameter has no effect
      if chimera_method is "none".
    type: double
  n_reads_learn:
    default: 1000000
    doc: The number of reads to use when training the error model. Smaller numbers
      will result in a shorter run time but a less reliable error model.
    type: long
  n_threads:
    default: 1
    doc: The number of threads to use for multithreaded processing. If 0 is provided,
      all available cores will be used.
    type: long
  trim_left:
    default: 0
    doc: Position at which sequences should be trimmed due to low quality. This trims
      the 5' end of the of the input sequences, which will be the bases that were
      sequenced in the first cycles.
    type: long
  trunc_len:
    default: null
    doc: Position at which sequences should be truncated due to decrease in quality.
      This truncates the 3' end of the of the input sequences, which will be the bases
      that were sequenced in the last cycles. Reads that are shorter than this value
      will be discarded. If 0 is provided, no truncation or length filtering will
      be performed
    type: long
  trunc_q:
    default: 2
    doc: Reads are truncated at the first instance of a quality score less than or
      equal to this value. If the resulting read is then shorter than `trunc_len`,
      it is discarded.
    type: long
outputs:
  denoising_stats:
    doc: null
    label: denoising_stats
    outputBinding:
      glob: denoising_stats.qzv
    type: File
  representative_sequences:
    doc: The resulting feature sequences. Each feature in the feature table will be
      represented by exactly one sequence.
    label: representative_sequences
    outputBinding:
      glob: representative_sequences.qzv
    type: File
  table:
    doc: The resulting feature table.
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
