#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- heatmap
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.visualizers.heatmap
inputs:
  cluster:
    default: both
    doc: Specify which axes to cluster.
    type: string
  color_scheme:
    default: rocket
    doc: The matplotlib colorscheme to generate the heatmap with.
    type: string
  metadata:
    doc: Annotate the sample IDs with these metadata values. When metadata is present
      and `cluster`='feature', samples will be sorted by the metadata values.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  method:
    default: average
    doc: Clustering methods exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  metric:
    default: euclidean
    doc: Metrics exposed by seaborn (see http://seaborn.pydata.org/generated/seaborn.clustermap.html#seaborn.clustermap
      for more detail).
    type: string
  normalize:
    default: true
    doc: Normalize the feature table by adding a psuedocount of 1 and then taking
      the log10 of the table.
    type: boolean
  table:
    doc: The feature table to visualize.
    label: table
    type: File
  title:
    default: null
    doc: Optional custom plot title.
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
