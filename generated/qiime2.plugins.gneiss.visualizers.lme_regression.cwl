#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- lme_regression
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.visualizers.lme_regression
inputs:
  formula:
    default: null
    doc: Statistical formula specifying the statistical model.
    type: string
  groups:
    default: null
    doc: null
    type: string
  metadata:
    doc: Metadata information that contains the covariates of interest.
    type:
    - File
    - File[]
  table:
    doc: The feature table containing the samples in which simplicial regression with
      mixed effects will be performedwill be performed.
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
