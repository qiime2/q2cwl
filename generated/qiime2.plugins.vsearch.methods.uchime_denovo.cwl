#!/usr/bin/env cwl-runner

arguments:
- run
- vsearch
- uchime_denovo
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.vsearch.methods.uchime_denovo
inputs:
  dn:
    default: 1.4
    doc: No vote pseudo-count, corresponding to the parameter n in the chimera scoring
      function.
    type: double
  mindiffs:
    default: 3
    doc: Minimum number of differences per segment.
    type: long
  mindiv:
    default: 0.8
    doc: Minimum divergence from closest parent.
    type: double
  minh:
    default: 0.28
    doc: Minimum score (h). Increasing this value tends to reduce the number of false
      positives and to decrease sensitivity.
    type: double
  sequences:
    doc: The feature sequences to be chimera-checked.
    label: sequences
    type: File
  table:
    doc: Feature table (used for computing total feature abundances).
    label: table
    type: File
  xn:
    default: 8.0
    doc: No vote weight, corresponding to the parameter beta in the scoring function.
    type: double
outputs:
  chimeras:
    doc: The chimeric sequences.
    label: chimeras
    outputBinding:
      glob: chimeras.qzv
    type: File
  nonchimeras:
    doc: The non-chimeric sequences.
    label: nonchimeras
    outputBinding:
      glob: nonchimeras.qzv
    type: File
  stats:
    doc: Summary statistics from chimera checking.
    label: stats
    outputBinding:
      glob: stats.qzv
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
