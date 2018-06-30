#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- gradient_clustering
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.methods.gradient_clustering
inputs:
  gradient:
    doc: Contains gradient values to sort the features and samples.
    type: File
  gradient_column:
    doc: Column name to use from 'gradient'
    type: string
  table:
    doc: The feature table containing the samples in which the columns will be clustered.
    label: table
    type: File
  weighted:
    default: true
    doc: Specifies if abundance or presence/absence information should be used to
      perform the clustering.
    type: boolean
outputs:
  clustering:
    doc: A hierarchy of feature identifiers where each tip corresponds to the feature
      identifiers in the table. This tree can contain tip ids that are not present
      in the table, but all feature ids in the table must be present in this tree.
    label: clustering
    outputBinding:
      glob: clustering.qzv
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
