#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- balance_taxonomy
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.visualizers.balance_taxonomy
inputs:
  balance_name:
    default: null
    doc: Name of the balance to summarize.
    type: string
  metadata:
    doc: Metadata column for plotting the balance (optional).
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  n_features:
    default: 10
    doc: The number of features to plot in the proportion plot.
    type: long
  table:
    doc: A table of compositions.
    label: table
    type: File
  taxa_level:
    default: 0
    doc: Level of taxonomy to summarize.
    type: long
  taxonomy:
    doc: Taxonomy information for the OTUs.
    label: taxonomy
    type: File
  threshold:
    default: null
    doc: A threshold to designate discrete categories for a numerical metadata column.
      This will split the numerical column values into two categories, values below
      the threshold, and values above the threshold. If not specified, this threshold
      will default to the mean.
    type: double?
  tree:
    doc: The tree used to calculate the balances.
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
