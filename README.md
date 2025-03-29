# mhcflow

[![PyPI version](https://img.shields.io/pypi/v/mhcflow)](https://pypi.org/project/mhcflow/)
![Python versions](https://img.shields.io/pypi/pyversions/mhcflow)
![License](https://img.shields.io/pypi/l/mhcflow)

MHC class I and II typing workflow including fishing, realigning, and typing that
generates results ready for detection of HLA loss of heterozygosity (LOH) and
peptide binding prediction.

## Installation

Starting from `v0.2.0`, `mhcflow` can be installed from PyPI:

```bash
pip install mhcflow
```

If you prefer to use the shell script implementation, please check out the
`v0.1.0` branch of this repo. For details on how to use the `v0.1.0` version,
please refer to the [documentation](https://svm-zhang.github.io/mhcflow).

## Quick start

`mhcflow` simply requires the following inputs:

- Genomic alignment in BAM format: `$bam`.
- HLA reference sequence in Fasta format: `$ref`.
- Kmer pattern, a.k.a the tag file: `$tag`.
- Regions of HLA alleles in BED format: `$bed`.
- Population frequency from the original `polysolver`: `HLA_FREQ.txt`.
- Path to output directory where all results will be dumped: `$outdir`.

```bash
mhcflow --bam "$bam" \
    --ref "$ref" \
    --tag "$tag" \
    --bed "$bed" \
    --freq "HLA_FREQ.txt" \
    --outdir "$outdir" \
```

Please refer to [documentation](https://svm-zhang.github.io/mhcflow) for more details.
