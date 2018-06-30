#!/usr/bin/env cwl-runner

arguments:
- run
- gneiss
- assign_ids
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.gneiss.methods.assign_ids
inputs:
  input_table:
    doc: The input table of counts.
    label: input_table
    type: File
  input_tree:
    doc: The input tree with potential missing ids.
    label: input_tree
    type: File
outputs:
  output_table:
    doc: A table with features matching the tree tips.
    label: output_table
    outputBinding:
      glob: output_table.qzv
    type: File
  output_tree:
    doc: A tree with uniquely identifying ids.
    label: output_tree
    outputBinding:
      glob: output_tree.qzv
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
