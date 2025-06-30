#!/bin/bash

# Default data set if not specified
DEFAULT_REF="class_i" # Or whatever you prefer

# Determine the data set from the environment variable, or use default
REF="${MHCFLOW_REF:-$DEFAULT_REF}"

# Define argument sets
case "$REF" in
"class_i" | "i" | "1")
  # class I reference set
  FIXED_ARGS=(
    "--ref" "/resources/class_i/abc_complete.fasta"
    "--tag" "/resources/class_i/abc_v14.uniq"
    "--bed" "/resources/class_i/hla.bed"
    "--freq" "/resources/class_i/HLA_FREQ.txt"
  )
  ;;
"class_ii" | "ii" | "2")
  # class II reference set
  FIXED_ARGS=(
    "--ref" "/resources/class_ii/class2.ref.fasta"
    "--tag" "/resources/class_ii/class2.ref.38mer.tag"
    "--bed" "/resources/class_ii/class2.bed"
    "--freq" "/resources_ii/class2.ref.supertype.freq.tsv"
  )
  ;;
*)
  echo "ERROR: Invalid MHCFLOW_REF value: '$REF'."
  echo "For class I: either class_i, or i, or 1."
  echo "For class II: either class_ii, or ii, or 2."
  exit 1
  ;;
esac

exec mhcflow "${FIXED_ARGS[@]}" "$@"
