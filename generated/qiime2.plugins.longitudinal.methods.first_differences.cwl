#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- first_differences
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.methods.first_differences
inputs:
  baseline:
    default: null
    doc: A value listed in the state_column metadata column against which all other
      states should be compared. Toggles calculation of static differences instead
      of first differences (which are calculated if no value is given for baseline).
      If a "baseline" value is provided, sample differences at each state are compared
      against the baseline state, instead of the previous state. Must be a value listed
      in the state_column.
    type: double?
  individual_id_column:
    default: null
    doc: Metadata column containing IDs for individual subjects.
    type: string
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
  metric:
    default: null
    doc: Numerical metadata or artifact column to test.
    type: string
  replicate_handling:
    default: error
    doc: Choose how replicate samples are handled. If replicates are detected, "error"
      causes method to fail; "drop" will discard all replicated samples; "random"
      chooses one representative at random from among replicates.
    type: string
  state_column:
    default: null
    doc: Metadata column containing state (e.g., Time) across which samples are paired.
    type: string
  table:
    doc: Feature table to optionally use for computing first differences.
    label: table
    type: File?
outputs:
  first_differences:
    doc: Series of first differences.
    label: first_differences
    outputBinding:
      glob: first_differences.qzv
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
