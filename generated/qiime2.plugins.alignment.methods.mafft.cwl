#!/usr/bin/env cwl-runner

arguments:
- run
- alignment
- mafft
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.alignment.methods.mafft
inputs:
  n_threads:
    default: 1
    doc: The number of threads. (Use -1 to automatically use all available cores)
    type: long
  sequences:
    doc: The sequences to be aligned.
    label: sequences
    type: File
outputs:
  alignment:
    doc: The aligned sequences.
    label: alignment
    outputBinding:
      glob: alignment.qzv
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
