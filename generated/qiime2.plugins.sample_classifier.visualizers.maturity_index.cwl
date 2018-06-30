#!/usr/bin/env cwl-runner

arguments:
- run
- sample_classifier
- maturity_index
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.sample_classifier.visualizers.maturity_index
inputs:
  column:
    default: null
    doc: Numeric metadata column to use as prediction target.
    type: string
  control:
    default: null
    doc: Value of group_by to use as control group. The regression model will be trained
      using only control group data, and the maturity scores of other groups consequently
      will be assessed relative to this group.
    type: string
  cv:
    default: 5
    doc: Number of k-fold cross-validations to perform.
    type: long
  estimator:
    default: RandomForestRegressor
    doc: Regression model to use for prediction.
    type: string
  group_by:
    default: null
    doc: Categorical metadata column to use for plotting and significance testing
      between main treatment groups.
    type: string
  maz_stats:
    default: true
    doc: Calculate anova and pairwise tests on MAZ scores.
    type: boolean
  metadata:
    doc: null
    type:
    - File
    - File[]
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
    default: true
    doc: Automatically optimize input feature selection using recursive feature elimination.
    type: boolean
  parameter_tuning:
    default: true
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
  stratify:
    default: false
    doc: Evenly stratify training and test data among metadata categories. If True,
      all values in column must match at least two samples.
    type: boolean
  table:
    doc: Feature table containing all features that should be used for target prediction.
    label: table
    type: File
  test_size:
    default: 0.2
    doc: Fraction of input samples to exclude from training set and use for classifier
      testing.
    type: double
outputs:
  visualization:
    doc: null
    label: visualization
    outputBinding:
      glob: visualization.qzv
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
