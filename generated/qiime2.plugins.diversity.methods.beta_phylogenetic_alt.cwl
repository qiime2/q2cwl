#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- beta_phylogenetic_alt
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.beta_phylogenetic_alt
inputs:
  alpha:
    default: null
    doc: This parameter is only used when the choice of metric is generalized_unifrac.
      The value of alpha controls importance of sample proportions. 1.0 is weighted
      normalized UniFrac. 0.0 is close to unweighted UniFrac, but only if the sample
      proportions are dichotomized.
    type: double?
  bypass_tips:
    default: false
    doc: In a bifurcating tree, the tips make up about 50% of the nodes in a tree.
      By ignoring them, specificity can be traded for reduced compute time. This has
      the effect of collapsing the phylogeny, and is analogous (in concept) to moving
      from 99% to 97% OTUs
    type: boolean
  metric:
    default: null
    doc: The beta diversity metric to be computed.
    type: string
  n_jobs:
    default: 1
    doc: The number of workers to use.
    type: long
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    label: phylogeny
    type: File
  table:
    doc: The feature table containing the samples over which beta diversity should
      be computed.
    label: table
    type: File
  variance_adjusted:
    default: false
    doc: Perform variance adjustment based on Chang et al. BMC Bioinformatics 2011.
      Weights distances based on the proportion of the relative abundance represented
      between the samples at a given node under evaluation.
    type: boolean
outputs:
  distance_matrix:
    doc: The resulting distance matrix.
    label: distance_matrix
    outputBinding:
      glob: distance_matrix.qzv
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
