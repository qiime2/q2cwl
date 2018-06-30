#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- core_metrics_phylogenetic
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.pipelines.core_metrics_phylogenetic
inputs:
  metadata:
    doc: The sample metadata to use in the emperor plots.
    type:
    - File
    - File[]
  n_jobs:
    default: 1
    doc: '[beta/beta-phylogenetic methods only, excluding weighted_unifrac] - The
      number of jobs to use for the computation. This works by breaking down the pairwise
      matrix into n_jobs even slices and computing them in parallel. If -1 all CPUs
      are used. If 1 is given, no parallel computing code is used at all, which is
      useful for debugging. For n_jobs below -1, (n_cpus + 1 + n_jobs) are used. Thus
      for n_jobs = -2, all CPUs but one are used. (Description from sklearn.metrics.pairwise_distances)'
    type: long
  phylogeny:
    doc: Phylogenetic tree containing tip identifiers that correspond to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    label: phylogeny
    type: File
  sampling_depth:
    default: null
    doc: The total frequency that each sample should be rarefied to prior to computing
      diversity metrics.
    type: long
  table:
    doc: The feature table containing the samples over which diversity metrics should
      be computed.
    label: table
    type: File
outputs:
  bray_curtis_distance_matrix:
    doc: Matrix of Bray-Curtis distances between pairs of samples.
    label: bray_curtis_distance_matrix
    outputBinding:
      glob: bray_curtis_distance_matrix.qzv
    type: File
  bray_curtis_emperor:
    doc: Emperor plot of the PCoA matrix computed from Bray-Curtis.
    label: bray_curtis_emperor
    outputBinding:
      glob: bray_curtis_emperor.qzv
    type: File
  bray_curtis_pcoa_results:
    doc: PCoA matrix computed from Bray-Curtis distances between samples.
    label: bray_curtis_pcoa_results
    outputBinding:
      glob: bray_curtis_pcoa_results.qzv
    type: File
  evenness_vector:
    doc: Vector of Pielou's evenness values by sample.
    label: evenness_vector
    outputBinding:
      glob: evenness_vector.qzv
    type: File
  faith_pd_vector:
    doc: Vector of Faith PD values by sample.
    label: faith_pd_vector
    outputBinding:
      glob: faith_pd_vector.qzv
    type: File
  jaccard_distance_matrix:
    doc: Matrix of Jaccard distances between pairs of samples.
    label: jaccard_distance_matrix
    outputBinding:
      glob: jaccard_distance_matrix.qzv
    type: File
  jaccard_emperor:
    doc: Emperor plot of the PCoA matrix computed from Jaccard.
    label: jaccard_emperor
    outputBinding:
      glob: jaccard_emperor.qzv
    type: File
  jaccard_pcoa_results:
    doc: PCoA matrix computed from Jaccard distances between samples.
    label: jaccard_pcoa_results
    outputBinding:
      glob: jaccard_pcoa_results.qzv
    type: File
  observed_otus_vector:
    doc: Vector of Observed OTUs values by sample.
    label: observed_otus_vector
    outputBinding:
      glob: observed_otus_vector.qzv
    type: File
  rarefied_table:
    doc: The resulting rarefied feature table.
    label: rarefied_table
    outputBinding:
      glob: rarefied_table.qzv
    type: File
  shannon_vector:
    doc: Vector of Shannon diversity values by sample.
    label: shannon_vector
    outputBinding:
      glob: shannon_vector.qzv
    type: File
  unweighted_unifrac_distance_matrix:
    doc: Matrix of unweighted UniFrac distances between pairs of samples.
    label: unweighted_unifrac_distance_matrix
    outputBinding:
      glob: unweighted_unifrac_distance_matrix.qzv
    type: File
  unweighted_unifrac_emperor:
    doc: Emperor plot of the PCoA matrix computed from unweighted UniFrac.
    label: unweighted_unifrac_emperor
    outputBinding:
      glob: unweighted_unifrac_emperor.qzv
    type: File
  unweighted_unifrac_pcoa_results:
    doc: PCoA matrix computed from unweighted UniFrac distances between samples.
    label: unweighted_unifrac_pcoa_results
    outputBinding:
      glob: unweighted_unifrac_pcoa_results.qzv
    type: File
  weighted_unifrac_distance_matrix:
    doc: Matrix of weighted UniFrac distances between pairs of samples.
    label: weighted_unifrac_distance_matrix
    outputBinding:
      glob: weighted_unifrac_distance_matrix.qzv
    type: File
  weighted_unifrac_emperor:
    doc: Emperor plot of the PCoA matrix computed from weighted UniFrac.
    label: weighted_unifrac_emperor
    outputBinding:
      glob: weighted_unifrac_emperor.qzv
    type: File
  weighted_unifrac_pcoa_results:
    doc: PCoA matrix computed from weighted UniFrac distances between samples.
    label: weighted_unifrac_pcoa_results
    outputBinding:
      glob: weighted_unifrac_pcoa_results.qzv
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
