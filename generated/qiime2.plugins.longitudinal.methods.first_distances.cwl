#!/usr/bin/env cwl-runner

arguments:
- run
- longitudinal
- first_distances
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.longitudinal.methods.first_distances
inputs:
  baseline:
    default: null
    doc: A value listed in the state_column metadata column against which all other
      states should be compared. Toggles calculation of static distances instead of
      first distances (which are calculated if no value is given for baseline). If
      a "baseline" value is provided, sample distances at each state are compared
      against the baseline state, instead of the previous state. Must be a value listed
      in the state_column.
    type: double?
  distance_matrix:
    doc: Matrix of distances between pairs of samples.
    label: distance_matrix
    type: File
  individual_id_column:
    default: null
    doc: Metadata column containing IDs for individual subjects.
    type: string
  metadata:
    doc: Sample metadata file containing individual_id_column.
    type:
    - File
    - File[]
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
outputs:
  first_distances:
    doc: Series of first distances.
    label: first_distances
    outputBinding:
      glob: first_distances.qzv
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
