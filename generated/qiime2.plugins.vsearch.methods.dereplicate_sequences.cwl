#!/usr/bin/env cwl-runner

arguments:
- run
- vsearch
- dereplicate_sequences
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.vsearch.methods.dereplicate_sequences
inputs:
  sequences:
    doc: The sequences to be dereplicated.
    label: sequences
    type: File
outputs:
  dereplicated_sequences:
    doc: The dereplicated sequences.
    label: dereplicated_sequences
    outputBinding:
      glob: dereplicated_sequences.qzv
    type: File
  dereplicated_table:
    doc: The table of dereplicated sequences.
    label: dereplicated_table
    outputBinding:
      glob: dereplicated_table.qzv
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
