#!/usr/bin/env cwl-runner

arguments:
- run
- sample_classifier
- predict
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.sample_classifier.methods.predict
inputs:
  n_jobs:
    default: 1
    doc: Number of jobs to run in parallel.
    type: long
  sample_estimator:
    doc: Sample estimator trained with fit_classifier or fit_regressor.
    label: sample_estimator
    type: File
  table:
    doc: Feature table containing all features that should be used for target prediction.
    label: table
    type: File
outputs:
  predictions:
    doc: Predicted target values for each input sample.
    label: predictions
    outputBinding:
      glob: predictions.qzv
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
