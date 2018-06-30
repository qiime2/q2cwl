#!/usr/bin/env cwl-runner

arguments:
- run
- feature_classifier
- extract_reads
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_classifier.methods.extract_reads
inputs:
  f_primer:
    default: null
    doc: forward primer sequence
    type: string
  identity:
    default: 0.8
    doc: minimum combined primer match identity threshold.
    type: double
  r_primer:
    default: null
    doc: reverse primer sequence
    type: string
  sequences:
    doc: null
    label: sequences
    type: File
  trim_left:
    default: 0
    doc: trim_left nucleotides are removed from the 5' end if trim_left is positive.
      Applied after trunc_len.
    type: long
  trunc_len:
    default: 0
    doc: read is cut to trunc_len if trunc_len is positive. Applied before trim_left.
    type: long
outputs:
  reads:
    doc: null
    label: reads
    outputBinding:
      glob: reads.qzv
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
