#!/usr/bin/env cwl-runner

arguments:
- run
- demux
- emp_single
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.demux.methods.emp_single
inputs:
  barcodes:
    doc: The sample metadata column containing the per-sample barcodes.
    type: File
  barcodes_column:
    doc: Column name to use from 'barcodes'
    type: string
  rev_comp_barcodes:
    default: false
    doc: If provided, the barcode sequence reads will be reverse complemented prior
      to demultiplexing.
    type: boolean
  rev_comp_mapping_barcodes:
    default: false
    doc: If provided, the barcode sequences in the sample metadata will be reverse
      complemented prior to demultiplexing.
    type: boolean
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
requirements:
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.utf8
      MPLBACKEND: Agg
  InitialWorkDirRequirement:
    listing:
    - entry: '{"_": $(inputs)}'
      entryname: inputs.json
