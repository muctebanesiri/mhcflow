# Getting started

## Quick start

To run `mhcflow`, simply do:

``` bash
mhcflow --bam [Genomic alignment] \
  --hla_ref [HLA reference sequence] \
  --bed [Regions of HLA alleles] \
  --tag [Kmer sequences file] \
  --freq [Allele population frequency] \
  --outdir [Path ot output folder]
```
## Input


### Genomic alignment

Provide coordiate-sorted and indexed alignments of sequencing reads against
a genomic reference that includes chromosome harboring MHC genes
(chromosome 6 for the human genome) via the `--bam` option.
The supplied alignment should contain at most one read group with `SM` field.


### HLA reference sequences

Provide the reference sequences of HLA alleles you intend to type in Fasta
format. Accompanying `.fai` and `.nix` reference indices  must be
present. You can either use the reference sequences provided by `polysolver`
(e.g. `abc_complete.fasta`) and `optitype`, or create a custom reference for
the alleles you to type. Additionally, `mhcflow` includes a reference for
MHC class II alleles in the `reference/class2` directory of this repository.


### Kmer sequences

Provide a plain text file containing a list of Kmer sequences extracted
from the same HLA reference used above. Each line in the file should contain
one kmer sequence. For example, `polysolver` comes with a file named
`abc_uniq.v14` that contains a set of 38mers. You can also generate a custom
Kmer sequence set from a HLA reference using your desired k value, with tools
such as `jellyfish`. Additionally, `mhcflow` includes a set Kmer sequences for
MHC class II alleles in the file, `class2.ref.polysolver.38mer.tag`.
Below is the first 5 kmer sequences in it.

```text
AAAAAAAAAAAAAAAAAAAAAGAAAGATCTCTGTGTAG
AAAAAAAAAAAAAAAAAAAAGAAAGATCTCTGTGTAGA
AAAAAAAAAAAAAAAAAAAGAAAGATCTCTGTGTAGAG
AAAAAAAAAAAAAAAAAAGAAAGAAAAAAAAGAAAAGA
AAAAAAAAAAAAAAAAAAGAAAGATCTCTGTGTAGAGT

```

### Regions of HLA alleles

Provide the genomic intervals for the HLA genes you wish to type in BED format.
Coordinates should be 0-based, and the chromosome names must match those
in the genomic alignment provided earlier. Only the first 3 columns of the BED
file will be used. Additionally, ensure that the coordinates are based on the
same genome build used for genomic alignment. Note that `mhcflow` extracts all reads
mapped to regions specified in the BED file, regardless of whether a Kmer
pattern is present. Below is an example set of intervals for MHC class II genes
(based on `hg19`) included in the `class2.chr_prefix_free.bed` file.

|    |           |           |
| :- | :-------  |  :------- |
| 6  | 32489683  | 32557613  |
| 6  | 32605183  | 32614839  |
| 6  | 32627241  | 32634466  |
| 6  | 33032346  | 33048555  |
| 6  | 33043767  | 33057473  |

### Allele population frequency

Provide a table of population frequencies for the supertype of HLA alleles
(i.e., a lower resolution representation) that you wish to type. Below
is a snapshot of first 4 class I supertype alleles in the `HLA_FREQ.txt` file
provided by `polysolver`:


| Allele        | Caucasian | Black | Asian |
| :------------ | :-------  | :-----| :---- |
| hla_a_01_01   | 0.143     | 0.047 | 0.012 |
| hla_a_01_02   | 0.000     | 0.006 | 0.000 |
| hla_a_01_03   | 0.000     | 0.001 | 0.000 |
| hla_a_01_04n   | 0.000     | 0.000 | 0.000 |


Each row represents one allele, while each column corresponds to a population
group.

Note that `mhcflow` (more specifically, its underlying component `mhctyper`)
will only type alleles with a non-zero cross-population frequency. In the
example shown above, supertyper `hla_a_01_04n` will not be typed.

You can also create a custom population frequency table by providing a list of
supertypes with "simulated" allele frequencies. These simulated frequencies act
as placeholder and does not reflect the true population frequencies, as they
are not used for calculating the log likelihood score during typing
in `mhctyper` (i.e. using `polysolver` with `--race unknown`).
For an example, in `class2.ref.polysolver.supertype.freq.tsv`,
the population frequencies for all supertype alleles are simulated to 0.1.


## Example: run mhcflow on sample from 1000 genome project

In this example, we will type class I alleles for the NA18740 sample from the
1000 Genomes Project. Throughout this documentation, NA18740 is used as the
example sample. The HLA reference sequence, Kmer sequence, and population
frequency table used here are the exact files provided by `polysolver`.

``` bash
mhcflow --bam NA18740.so.bam \
  --hla_ref abc_complete.fasta \
  --bed hla.bed \
  --tag abc_uniq.v14 \
  --freq HLA_FREQ.txt \
  --outdir [Path ot output folder]
```

Make sure to replace `NA18740.so.bam` and [Path to output folder] with the
appropriate file paths for your analysis.

## Output

The command above generates HLA typing results in the designated output
directory specified by `--outdir` option. The foler structure looks like:

 
``` { .sh }
.
├─ NA18740_class1/
│  ├─ finalizer/
│  ├─ fisher/
│  ├─ realigner/
│  └─ typer/
```

The `finalizer` directory contains the reference sequence for typed alleles for
sample NA18740 in Fasta format, along with the realignments against these
alleles. Both files can be directly used for HLA loss-of-heterozygosity detection.

For a detailed walkthrough of the output, please refer to the
[Explain Output page](https://svm-zhang.github.io/mhcflow/output/).



