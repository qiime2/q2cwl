#!/usr/bin/env cwl-runner

arguments:
- run
- emperor
- procrustes_plot
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.emperor.visualizers.procrustes_plot
inputs:
  custom_axes:
    default: null
    doc: Numeric sample metadata columns that should be included as axes in the Emperor
      plot.
    type: string[]?
  metadata:
    doc: The sample metadata.
    type:
    - File
    - File[]
  other_pcoa:
    doc: The "other" ordination matrix to be plotted (the one that was fitted to the
      reference).
    label: other_pcoa
    type: File
  reference_pcoa:
    doc: The reference ordination matrix to be plotted.
    label: reference_pcoa
    type: File
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
