#!/usr/bin/env cwl-runner

arguments:
- run
- quality_control
- evaluate_composition
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.quality_control.visualizers.evaluate_composition
inputs:
  depth:
    default: 7
    doc: Maximum depth of semicolon-delimited taxonomic ranks to test (e.g., 1 = root,
      7 = species for the greengenes reference sequence database).
    type: long
  expected_features:
    doc: Expected feature compositions
    label: expected_features
    type: File
  metadata:
    doc: Optional sample metadata that maps observed_features sample IDs to expected_features
      sample IDs.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  observed_features:
    doc: Observed feature compositions
    label: observed_features
    type: File
  palette:
    default: Set1
    doc: Color palette to utilize for plotting.
    type: string
  plot_bray_curtis:
    default: false
    doc: Plot expected vs. observed Bray-Curtis dissimilarity scores on score plot.
    type: boolean
  plot_jaccard:
    default: false
    doc: Plot expected vs. observed Jaccard distances scores on score plot.
    type: boolean
  plot_observed_features:
    default: false
    doc: Plot observed features count on score plot.
    type: boolean
  plot_observed_features_ratio:
    default: true
    doc: Plot ratio of observed:expected features on score plot.
    type: boolean
  plot_r_squared:
    default: true
    doc: Plot expected vs. observed linear regression r-squared value on score plot.
    type: boolean
  plot_r_value:
    default: false
    doc: Plot expected vs. observed linear regression r value on score plot.
    type: boolean
  plot_tar:
    default: true
    doc: Plot taxon accuracy rate (TAR) on score plot. TAR is the number of true positive
      features divided by the total number of observed features (TAR = true positives
      / (true positives + false positives)).
    type: boolean
  plot_tdr:
    default: true
    doc: Plot taxon detection rate (TDR) on score plot. TDR is the number of true
      positive features divided by the total number of expected features (TDR = true
      positives / (true positives + false negatives)).
    type: boolean
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
