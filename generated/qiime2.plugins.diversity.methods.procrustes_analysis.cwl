#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- procrustes_analysis
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.methods.procrustes_analysis
inputs:
  dimensions:
    default: 5
    doc: null
    type: long
  other:
    doc: The ordination matrix that's fitted to the reference ordination.
    label: other
    type: File
  reference:
    doc: The ordination matrix to which data is fitted to.
    label: reference
    type: File
outputs:
  transformed_other:
    doc: A normalized and fitted version of the "other" ordination matrix.
    label: transformed_other
    outputBinding:
      glob: transformed_other.qzv
    type: File
  transformed_reference:
    doc: A normalized version of the "reference" ordination matrix.
    label: transformed_reference
    outputBinding:
      glob: transformed_reference.qzv
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
