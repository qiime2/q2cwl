#!/usr/bin/env cwl-runner

arguments:
- run
- diversity
- mantel
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.diversity.visualizers.mantel
inputs:
  dm1:
    doc: Matrix of distances between pairs of samples.
    label: dm1
    type: File
  dm2:
    doc: Matrix of distances between pairs of samples.
    label: dm2
    type: File
  intersect_ids:
    default: false
    doc: If supplied, IDs that are not found in both distance matrices will be discarded
      before applying the Mantel test. Default behavior is to error on any mismatched
      IDs.
    type: boolean
  label1:
    default: Distance Matrix 1
    doc: Label for `dm1` in the output visualization.
    type: string
  label2:
    default: Distance Matrix 2
    doc: Label for `dm2` in the output visualization.
    type: string
  method:
    default: spearman
    doc: The correlation test to be applied in the Mantel test.
    type: string
  permutations:
    default: 999
    doc: The number of permutations to be run when computing p-values. Supplying a
      value of zero will disable permutation testing and p-values will not be calculated
      (this results in *much* quicker execution time if p-values are not desired).
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
