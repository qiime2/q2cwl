#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- alpha_rarefaction
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.visualizers.alpha_rarefaction
inputs:
  iterations:
    default: 10
    doc: The number of rarefied feature tables to compute at each step.
    type: long
  max_depth:
    default: null
    doc: The maximum rarefaction depth. Must be greater than min_depth.
    type: long
  metadata:
    doc: The sample metadata.
    type:
    - File?
    - File[]?
  metrics:
    default: null
    doc: The metrics to be measured. By default computes observed_otus, shannon, and
      if phylogeny is provided, faith_pd.
    type: string[]?
  min_depth:
    default: 1
    doc: The minimum rarefaction depth.
    type: long
  phylogeny:
    doc: Optional phylogeny for phylogenetic metrics.
    label: phylogeny
    type: File?
  steps:
    default: 10
    doc: The number of rarefaction depths to include between min_depth and max_depth.
    type: long
  table:
    doc: Feature table to compute rarefaction curves from.
    label: table
    type: File
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
