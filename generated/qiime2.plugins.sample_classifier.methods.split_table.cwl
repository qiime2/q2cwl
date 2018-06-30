#!/usr/bin/env cwl-runner

arguments:
- run
- sample_classifier
- split_table
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.sample_classifier.methods.split_table
inputs:
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
  random_state:
    default: null
    doc: Seed used by random number generator.
    type: long?
  stratify:
    default: true
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
  test_table:
    doc: Feature table containing test samples
    label: test_table
    outputBinding:
      glob: test_table.qzv
    type: File
  training_table:
    doc: Feature table containing training samples
    label: training_table
    outputBinding:
      glob: training_table.qzv
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
