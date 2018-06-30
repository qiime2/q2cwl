#!/usr/bin/env cwl-runner

arguments:
- run
- composition
- add_pseudocount
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.composition.methods.add_pseudocount
inputs:
  pseudocount:
    default: 1
    doc: The value to add to all counts in the feature table.
    type: long
  table:
    doc: The feature table to which pseudocounts should be added.
    label: table
    type: File
outputs:
  composition_table:
    doc: The resulting feature table.
    label: composition_table
    outputBinding:
      glob: composition_table.qzv
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
