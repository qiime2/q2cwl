#!/usr/bin/env cwl-runner

arguments:
- run
- composition
- ancom
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.composition.visualizers.ancom
inputs:
  difference_function:
    default: null
    doc: The method applied to visualize fold difference in feature abundances across
      groups for volcano plots.
    type: string?
  metadata:
    doc: The categorical sample metadata column to test for differential abundance
      across.
    type: File
  metadata_column:
    doc: Column name to use from 'metadata'
    type: string
  table:
    doc: The feature table to be used for ANCOM computation.
    label: table
    type: File
  transform_function:
    default: clr
    doc: The method applied to transform feature values before generating volcano
      plots.
    type: string
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
