#!/usr/bin/env cwl-runner

arguments:
- run
- feature_classifier
- fit_classifier_naive_bayes
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_classifier.methods.fit_classifier_naive_bayes
inputs:
  class_weight:
    doc: null
    label: class_weight
    type: File?
  classify__alpha:
    default: 0.001
    doc: null
    type: double
  classify__chunk_size:
    default: 20000
    doc: null
    type: long
  classify__class_prior:
    default: 'null'
    doc: null
    type: string
  classify__fit_prior:
    default: false
    doc: null
    type: boolean
  feat_ext__alternate_sign:
    default: false
    doc: null
    type: boolean
  feat_ext__analyzer:
    default: char_wb
    doc: null
    type: string
  feat_ext__binary:
    default: false
    doc: null
    type: boolean
  feat_ext__decode_error:
    default: strict
    doc: null
    type: string
  feat_ext__encoding:
    default: utf-8
    doc: null
    type: string
  feat_ext__input:
    default: content
    doc: null
    type: string
  feat_ext__lowercase:
    default: true
    doc: null
    type: boolean
  feat_ext__n_features:
    default: 8192
    doc: null
    type: long
  feat_ext__ngram_range:
    default: '[7, 7]'
    doc: null
    type: string
  feat_ext__non_negative:
    default: false
    doc: null
    type: boolean
  feat_ext__norm:
    default: l2
    doc: null
    type: string
  feat_ext__preprocessor:
    default: 'null'
    doc: null
    type: string
  feat_ext__stop_words:
    default: 'null'
    doc: null
    type: string
  feat_ext__strip_accents:
    default: 'null'
    doc: null
    type: string
  feat_ext__token_pattern:
    default: (?u)\b\w\w+\b
    doc: null
    type: string
  feat_ext__tokenizer:
    default: 'null'
    doc: null
    type: string
  reference_reads:
    doc: null
    label: reference_reads
    type: File
  reference_taxonomy:
    doc: null
    label: reference_taxonomy
    type: File
outputs:
  classifier:
    doc: null
    label: classifier
    outputBinding:
      glob: classifier.qzv
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
