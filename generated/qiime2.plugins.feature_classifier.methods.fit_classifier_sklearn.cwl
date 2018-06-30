#!/usr/bin/env cwl-runner

arguments:
- run
- feature_classifier
- fit_classifier_sklearn
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_classifier.methods.fit_classifier_sklearn
inputs:
  class_weight:
    doc: null
    label: class_weight
    type: File?
  classifier_specification:
    default: null
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
