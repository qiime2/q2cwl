#!/usr/bin/env cwl-runner

arguments:
- run
- quality_control
- evaluate_seqs
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.quality_control.visualizers.evaluate_seqs
inputs:
  query_sequences:
    doc: Sequences to test for exclusion
    label: query_sequences
    type: File
  reference_sequences:
    doc: Reference sequences to align against feature sequences
    label: reference_sequences
    type: File
  show_alignments:
    default: false
    doc: Option to plot pairwise alignments of query sequences and their top hits.
    type: boolean
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
