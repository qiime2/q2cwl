#!/usr/bin/env cwl-runner

arguments:
- run
- sample_classifier
- fit_regressor
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.sample_classifier.methods.fit_regressor
inputs:
  cv:
    default: 5
    doc: Number of k-fold cross-validations to perform.
    type: long
  estimator:
    default: RandomForestRegressor
    doc: Estimator method to use for sample prediction.
    type: string
  metadata:
    doc: Numeric metadata column to use as prediction target.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  missing_samples:
    default: error
    doc: How to handle missing samples in metadata. "error" will fail if missing samples
      are detected. "ignore" will cause the feature table and metadata to be filtered,
      so that only samples found in both files are retained.
    type: string
  n_estimators:
    default: 100
    doc: Number of trees to grow for estimation. More trees will improve predictive
      accuracy up to a threshold level, but will also increase time and memory requirements.
      This parameter only affects ensemble estimators, such as Random Forest, AdaBoost,
      ExtraTrees, and GradientBoosting.
    type: long
  n_jobs:
    default: 1
    doc: Number of jobs to run in parallel.
    type: long
  optimize_feature_selection:
    default: false
    doc: Automatically optimize input feature selection using recursive feature elimination.
    type: boolean
  parameter_tuning:
    default: false
    doc: Automatically tune hyperparameters using random grid search.
    type: boolean
  random_state:
    default: null
    doc: Seed used by random number generator.
    type: long?
  step:
    default: 0.05
    doc: If optimize_feature_selection is True, step is the percentage of features
      to remove at each iteration.
    type: double
  table:
    doc: Feature table containing all features that should be used for target prediction.
    label: table
    type: File
outputs:
  feature_importance:
    doc: Importance of each input feature to model accuracy.
    label: feature_importance
    outputBinding:
      glob: feature_importance.qzv
    type: File
  sample_estimator:
    doc: null
    label: sample_estimator
    outputBinding:
      glob: sample_estimator.qzv
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
