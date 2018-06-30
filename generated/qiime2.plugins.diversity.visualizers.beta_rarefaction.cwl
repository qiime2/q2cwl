#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- beta_rarefaction
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.visualizers.beta_rarefaction
inputs:
  clustering_method:
    default: null
    doc: Samples can be clustered with neighbor joining or UPGMA. An arbitrary rarefaction
      trial will be used for the tree, and the remaining trials are used to calculate
      the support of the internal nodes of that tree.
    type: string
  color_scheme:
    default: BrBG
    doc: The matplotlib color scheme to generate the heatmap with.
    type: string
  correlation_method:
    default: spearman
    doc: The Mantel correlation test to be applied when computing correlation between
      beta diversity distance matrices.
    type: string
  iterations:
    default: 10
    doc: Number of times to rarefy the feature table at a given sampling depth.
    type: long
  metadata:
    doc: The sample metadata used for the Emperor jackknifed PCoA plot.
    type:
    - File
    - File[]
  metric:
    default: null
    doc: The beta diversity metric to be computed.
    type: string
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
      [required for phylogenetic metrics]
    label: phylogeny
    type: File?
  sampling_depth:
    default: null
    doc: The total frequency that each sample should be rarefied to prior to computing
      the diversity metric.
    type: long
  table:
    doc: Feature table upon which to perform beta diversity rarefaction analyses.
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
