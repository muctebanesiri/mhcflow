# Limitation

- In theory, mhcflow can be applied to datasets generated from targeted
and/or amplicon-based sequencing techniques that capture a large number of
reads from HLA regions (often with many PCR duplicates). However, this application
comes with a significant runtime cost during the realignment step, unless
sufficient computational resources are available to efficiently split
the workload into smaller tasks.

- `mhcflow` outputs the fished reads as uncompressed fastq files in the
process, which can consume considerable
disk space depending on the size of a sequencing library and the targeted
coverage of the HLA regions, etc. This issue stems from the academia version of
`novoalign` which does not support compressed fastq input. A future request
may introduce a `--gz` option for compression if you have access to the
commercial version.

- Starting with `v0.2.0`, individual components in `mhcflow` are no longer
accessible via the command line as they were in `v0.1.0`. Enabling
command-line execution for each component remains a potential future feature.

- The current method for splitting the realignment workload is rather naive
and does not guarantee balanced distribution across tasks. This imbalance
may result in some realignment tasks waiting for one particularly
time-consuming workload to complete.

- The typing algorithm derived from `polysolver` (implemented by the
[mhctyper](https://svm-zhang.github.io/mhctyper/)
component) can be sensitive to fluctuations in the number of reads realigned.
It reports only the alleles with the highest scores as the final results.
Examining the top 3 or 5 alleles is recommended if the final results are
unexpected, because even one single additional alignment might shift the
score difference.
