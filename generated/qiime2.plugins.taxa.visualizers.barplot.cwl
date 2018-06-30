#!/usr/bin/env cwl-runner

arguments:
- run
- taxa
- barplot
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.taxa.visualizers.barplot
inputs:
  metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  table:
    doc: Feature table to visualize at various taxonomic levels.
    label: table
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature table. All features
      in the feature table must have a corresponding taxonomic annotation. Taxonomic
      annotations that are not present in the feature table will be ignored.
    label: taxonomy
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
