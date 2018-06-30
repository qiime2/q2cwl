#!/usr/bin/env cwl-runner

arguments:
- run
- demux
- summarize
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.demux.visualizers.summarize
inputs:
  data:
    doc: The demultiplexed sequences to be summarized.
    label: data
    type: File
  n:
    default: 10000
    doc: The number of sequences that should be selected at random for quality score
      plots. The quality plots will present the average positional qualities across
      all of the sequences selected. If input sequences are paired end, plots will
      be generated for both forward and reverse reads for the same `n` sequences.
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
