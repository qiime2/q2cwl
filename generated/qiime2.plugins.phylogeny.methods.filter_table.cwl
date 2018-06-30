#!/usr/bin/env cwl-runner

arguments:
- run
- phylogeny
- filter_table
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.phylogeny.methods.filter_table
inputs:
  table:
    doc: Feature table that features should be filtered from.
    label: table
    type: File
  tree:
    doc: Tree where tip identifiers are the feature identifiers that should be retained
      in the table.
    label: tree
    type: File
outputs:
  filtered_table:
    doc: The resulting feature table.
    label: filtered_table
    outputBinding:
      glob: filtered_table.qzv
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
