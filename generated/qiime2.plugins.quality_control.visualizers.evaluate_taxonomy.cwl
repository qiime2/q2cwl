#!/usr/bin/env cwl-runner

arguments:
- run
- quality_control
- evaluate_taxonomy
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.quality_control.visualizers.evaluate_taxonomy
inputs:
  depth:
    default: null
    doc: Maximum depth of semicolon-delimited taxonomic ranks to test (e.g., 1 = root,
      7 = species for the greengenes reference sequence database).
    type: long
  expected_taxa:
    doc: Expected taxonomic assignments
    label: expected_taxa
    type: File
  feature_table:
    doc: Optional feature table containing relative frequency of each feature, used
      to weight accuracy scores by frequency. Must contain all features found in expected
      and/or observed taxa. Features found in the table but not the expected/observed
      taxa will be dropped prior to analysis.
    label: feature_table
    type: File?
  observed_taxa:
    doc: Observed taxonomic assignments
    label: observed_taxa
    type: File
  palette:
    default: Set1
    doc: Color palette to utilize for plotting.
    type: string
  require_exp_ids:
    default: true
    doc: Require that all features found in observed taxa must be found in expected
      taxa or raise error.
    type: boolean
  require_obs_ids:
    default: true
    doc: Require that all features found in expected taxa must be found in observed
      taxa or raise error.
    type: boolean
  sample_id:
    default: null
    doc: Optional sample ID to use for extracting frequency data from feature table,
      and for labeling accuracy results. If no sample_id is provided, feature frequencies
      are derived from the sum of all samples present in the feature table.
    type: string?
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
