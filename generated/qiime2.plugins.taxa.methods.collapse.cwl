#!/usr/bin/env cwl-runner

arguments:
- run
- taxa
- collapse
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.taxa.methods.collapse
inputs:
  level:
    default: null
    doc: The taxonomic level at which the features should be collapsed. All ouput
      features will have exactly this many levels of taxonomic annotation.
    type: long
  table:
    doc: Feature table to be collapsed.
    label: table
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature table. All features
      in the feature table must have a corresponding taxonomic annotation. Taxonomic
      annotations that are not present in the feature table will be ignored.
    label: taxonomy
    type: File
outputs:
  collapsed_table:
    doc: The resulting feature table, where all features are now taxonomic annotations
      with the user-specified number of levels.
    label: collapsed_table
    outputBinding:
      glob: collapsed_table.qzv
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
