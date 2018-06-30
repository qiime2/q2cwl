#!/usr/bin/env cwl-runner

arguments:
- run
- metadata
- tabulate
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.metadata.visualizers.tabulate
inputs:
  input:
    doc: The metadata to tabulate.
    type:
    - File
    - File[]
  page_size:
    default: 100
    doc: The maximum number of Metadata records to display per page
    type: long
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
