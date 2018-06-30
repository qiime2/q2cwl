#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- dendrogram_heatmap
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.visualizers.dendrogram_heatmap
inputs:
  color_map:
    default: viridis
    doc: Specifies the color map for plotting the heatmap. See https://matplotlib.org/examples/color/colormaps_reference.html
      for more details.
    type: string
  metadata:
    doc: Categorical metadata column to group the samples.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  method:
    default: clr
    doc: Specifies how the data should be normalized for display.Options include 'log'
      or 'clr' (default='clr').
    type: string
  ndim:
    default: 10
    doc: Number of dimensions to highlight.
    type: long
  table:
    doc: The feature table that will be plotted as a heatmap. This table is assumed
      to have strictly positive values.
    label: table
    type: File
  tree:
    doc: A hierarchy of feature identifiers where each tipcorresponds to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    label: tree
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
