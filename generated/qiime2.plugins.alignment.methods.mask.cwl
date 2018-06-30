#!/usr/bin/env cwl-runner

arguments:
- run
- alignment
- mask
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.alignment.methods.mask
inputs:
  alignment:
    doc: The alignment to be masked.
    label: alignment
    type: File
  max_gap_frequency:
    default: 1.0
    doc: The maximum relative frequency of gap characters in a column for the column
      to be retained. This relative frequency must be a number between 0.0 and 1.0
      (inclusive), where 0.0 retains only those columns without gap characters, and
      1.0 retains all columns regardless of gap character frequency.
    type: double
  min_conservation:
    default: 0.4
    doc: The minimum relative frequency of at least one non-gap character in a column
      for that column to be retained. This relative frequency must be a number between
      0.0 and 1.0 (inclusive). For example, if a value of 0.4 is provided, a column
      will only be retained if it contains at least one character that is present
      in at least 40% of the sequences.
    type: double
outputs:
  masked_alignment:
    doc: The masked alignment.
    label: masked_alignment
    outputBinding:
      glob: masked_alignment.qzv
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
