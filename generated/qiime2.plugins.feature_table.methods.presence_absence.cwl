#!/usr/bin/env cwl-runner

arguments:
- run
- feature_table
- presence_absence
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.feature_table.methods.presence_absence
inputs:
  table:
    doc: The feature table to be converted into presence/absence abundances.
    label: table
    type: File
outputs:
  presence_absence_table:
    doc: The resulting presence/absence feature table.
    label: presence_absence_table
    outputBinding:
      glob: presence_absence_table.qzv
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
