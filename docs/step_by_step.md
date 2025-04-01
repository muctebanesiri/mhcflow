# Behind the scene

`mhcflow` features a modular design and is composed of
four components: `fisher`, `realigner`, `typer`, and `finalizer`. The purpose
of this page is to address the following questions:

- What does each component do?
- Which filter(s) are used (both explicitly and implicitly)?
- What are the limitations of the current implementation?

## Fisher

The `fisher` component extracts reads sequenced from DNA molecules originating
from MHC class I and II genes. It employs two primary strategies to identify
HLA-derived reads:

- Reads with Kmer sequence matches
- Reads mapped to the HLA regions specified in a BED file

### Kmer-matching reads

`mhcflow` utilizes the Aho-Corasick algorithm (via the
[pyahocorasick](https://pypi.org/project/pyahocorasick/) package) to efficiently
detect reads containing matching Kmer sequences. In this process, only reads
that are mapped to chromosome 6 or are unplaced in the genomic alignments
are analyzed. This targeted (greedy) approach is based on
experiments showing that the vast majority of Kmer-matching reads
originate from chromosome 6, while reads from other chromosomes contribute
negligibly. Due to the polymorphic nature of MHC sequences, `mhcflow`
also examines unplaced reads that have Kmer matches.

!!! note
    Unplaced reads refer to those that do not have a determined placement
    anywhere on a given reference-they are not considered unmapped by definition.

!!! note
    A limitation of this Kmer fishing strategy is that it only captures
    reads with exact matches. Consequently, any sequencing errors reduces
    its efficiency. To compensate for this limitation, 
    `mhcflow` also extracts all reads from a predefined list of
    HLA regions (regardless of the presence of Kmer sequence pattern),
    as described in the next section.
    

### Reads from HLA regions

Extracting all reads from a predefined list of HLA regions enables `mhcflow`
to capture HLA-derived reads that might be missed by the Kmer-fishing process
due to sequencing errors.

!!! note
    In its simplest form, you can specify only the regions to the HLA genes you
    intend to type, which generally produces good results. Alternatively, you
    may specify additional regions to potentially capture more HLA-derived
    reads. However, based on experiments with 1000 genome samples, obtaining more
    fished reads does not necessarily translate to improved typing accuracy.


### Other strategies

`mhcflow` implements the original fishing strategy from the `polysolver`
algorithm, which extracts reads from genomic alignments. There are alternative
approaches to capturing HLA-derived reads. For example, `Optitype`
directly aligns all reads from a sequencing sample against the HLA reference.

- Advantages
    - Captures HLA-derived reads with improved sensitivity. It not only
        detects a greater number of reads but also identify reads that
        are more likely to be HLA-derived.
    - Does not rely on genomic alignment and can be initiated at
        the begining of a workflow after reads trimming.
- Disadvantages
    - HLA-derived reads predominantly originate from
    chromosome 6, as mentioned earlier.
    - The razorS3 aligner used by `Optitype` is not memory-efficient. You
    must find a balance betten the number of threads and
    per-thread memory usage, which can be challenging with varying
    sequencing library sizes.


## Realigner

Coming soon...

## Typer: typing HLA class I genotype

Coming soon...

## Finalizer: collecting results

Coming soon...
