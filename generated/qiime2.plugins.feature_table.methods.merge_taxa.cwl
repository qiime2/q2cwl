#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- merge_taxa
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.merge_taxa
inputs:
  data:
    doc: The collection of feature taxonomies to be merged.
    label: data
    type: File[]
outputs:
  merged_data:
    doc: The resulting collection of feature taxonomies containing all feature taxonomies
      provided.
    label: merged_data
    outputBinding:
      glob: merged_data.qzv
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
