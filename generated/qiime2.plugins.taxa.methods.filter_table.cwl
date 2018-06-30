#!/usr/bin/env cwl-runner

arguments:
- run
- taxa
- filter_table
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.taxa.methods.filter_table
inputs:
  exclude:
    default: null
    doc: One or more search terms that indicate which taxa should be excluded from
      the resulting table. If providing more than one term, terms should be delimited
      by the query-delimiter character. By default, no taxa will be excluded.
    type: string?
  include:
    default: null
    doc: One or more search terms that indicate which taxa should be included in the
      resulting table. If providing more than one term, terms should be delimited
      by the query-delimiter character. By default, all taxa will be included.
    type: string?
  mode:
    default: contains
    doc: Mode for determining if a search term matches a taxonomic annotation. "contains"
      requires that the annotation has the term as a substring; "exact" requires that
      the annotation is a perfect match to a search term.
    type: string
  query_delimiter:
    default: ','
    doc: The string used to delimit multiple search terms provided to include or exclude.
      This parameter should only need to be modified if the default delimiter (a comma)
      is used in the provided taxonomic annotations.
    type: string
  table:
    doc: Feature table to be filtered.
    label: table
    type: File
  taxonomy:
    doc: Taxonomic annotations for features in the provided feature table. All features
      in the feature table must have a corresponding taxonomic annotation. Taxonomic
      annotations for features that are not present in the feature table will be ignored.
    label: taxonomy
    type: File
outputs:
  filtered_table:
    doc: The taxonomy-filtered feature table.
    label: filtered_table
    outputBinding:
      glob: filtered_table.qzv
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
