#!/usr/bin/env cwl-runner

arguments:
- run
- cutadapt
- trim_single
- inputs.json
baseCommand: q2cwl
class: CommandLineTool
cwlVersion: v1.0
id: qiime2.plugins.cutadapt.methods.trim_single
inputs:
  adapter:
    default: null
    doc: Sequence of an adapter ligated to the 3' end. The adapter and any subsequent
      bases are trimmed. If a `$` is appended, the adapter is only found if it is
      at the end of the read. If your sequence of interest is "framed" by a 5' and
      a 3' adapter, use this parameter to define a "linked" primer - see https://cutadapt.readthedocs.io
      for complete details.
    type: string[]?
  anywhere:
    default: null
    doc: Sequence of an adapter that may be ligated to the 5' or 3' end. Both types
      of matches as described under `adapter` and `front` are allowed. If the first
      base of the read is part of the match, the behavior is as with `front`, otherwise
      as with `adapter`. This option is mostly for rescuing failed library preparations
      - do not use if you know which end your adapter was ligated to.
    type: string[]?
  cores:
    default: 1
    doc: Number of CPU cores to use.
    type: long
  demultiplexed_sequences:
    doc: The single-end sequences to be trimmed.
    label: demultiplexed_sequences
    type: File
  error_rate:
    default: 0.1
    doc: Maximum allowed error rate.
    type: double
  front:
    default: null
    doc: Sequence of an adapter ligated to the 5' end. The adapter and any preceding
      bases are trimmed. Partial matches at the 5' end are allowed. If a `^` character
      is prepended, the adapter is only found if it is at the beginning of the read.
    type: string[]?
  indels:
    default: true
    doc: Allow insertions or deletions of bases when matching adapters.
    type: boolean
  match_adapter_wildcards:
    default: true
    doc: Interpret IUPAC wildcards (e.g., N) in adapters.
    type: boolean
  match_read_wildcards:
    default: false
    doc: Interpret IUPAC wildcards (e.g., N) in reads.
    type: boolean
  overlap:
    default: 3
    doc: Require at least `overlap` bases of overlap between read and adapter for
      an adapter to be found.
    type: long
  times:
    default: 1
    doc: Remove multiple occurrences of an adapter if it is repeated, up to `times`
      times.
    type: long
outputs:
  trimmed_sequences:
    doc: The resulting trimmed sequences.
    label: trimmed_sequences
    outputBinding:
      glob: trimmed_sequences.qzv
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
