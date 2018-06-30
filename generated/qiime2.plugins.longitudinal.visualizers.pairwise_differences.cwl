#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- pairwise_differences
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.visualizers.pairwise_differences
inputs:
  group_column:
    default: null
    doc: Metadata column on which to separate groups for comparison
    type: string?
  individual_id_column:
    default: null
    doc: 'Metadata column containing subject IDs to use for pairing samples. WARNING:
      if replicates exist for an individual ID at either state_1 or state_2, that
      subject will be dropped and reported in standard output by default. Set replicate_handling="random"
      to instead randomly select one member.'
    type: string
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  metric:
    default: null
    doc: Numerical metadata or artifact column to test.
    type: string
  palette:
    default: Set1
    doc: Color palette to use for generating boxplots.
    type: string
  parametric:
    default: false
    doc: Perform parametric (ANOVA and t-tests) or non-parametric (Kruskal-Wallis,
      Wilcoxon, and Mann-Whitney U tests) statistical tests.
    type: boolean
  replicate_handling:
    default: error
    doc: Choose how replicate samples are handled. If replicates are detected, "error"
      causes method to fail; "drop" will discard all replicated samples; "random"
      chooses one representative at random from among replicates.
    type: string
  state_1:
    default: null
    doc: Baseline state column value.
    type: string
  state_2:
    default: null
    doc: State column value to pair with baseline.
    type: string
  state_column:
    default: null
    doc: Metadata column containing state (e.g., Time) across which samples are paired.
    type: string
  table:
    doc: Feature table to optionally use for paired comparisons.
    label: table
    type: File?
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
