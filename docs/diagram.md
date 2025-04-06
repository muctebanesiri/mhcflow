# mhcflow diagram

Below is an overview of mhcflow workflow using the `--nproc 4` option.
``` mermaid
flowchart TD
    A["Genomic Alignment"]
    A --> B

    subgraph B [Fisher Component]
      direction LR
      FC1["Fish Chromosome 6"]
      FC2["Fish HLA Region"]
      FC3["Fish Unplaced"]
      FC1 --> U["Union of Fished IDs"]
      FC2 --> U
      FC3 --> U
    end

    U --> SU["Split Fished IDs to 4 Subsets"]
    SU --> S1["Fished ID Subset 1"]
    SU --> S2["Fished ID Subset 2"]
    SU --> S3["Fished ID Subset 3"]
    SU --> S4["Fished ID Subset 4"]

    S1 --> FQ1["Fished Fastq 1"]
    S2 --> FQ2["Fished Fastq 2"]
    S3 --> FQ3["Fished Fastq 3"]
    S4 --> FQ4["Fished Fastq 4"]

    FQ1 --> R1["Realigner Process 1"]
    FQ2 --> R2["Realigner Process 2"]
    FQ3 --> R3["Realigner Process 3"]
    FQ4 --> R4["Realigner Process 4"]

    R1 --> BAM1["BAM 1"]
    R2 --> BAM2["BAM 2"]
    R3 --> BAM3["BAM 3"]
    R4 --> BAM4["BAM 4"]

    BAM1 --> CAT["Concatenate BAM"]
    BAM2 --> CAT
    BAM3 --> CAT
    BAM4 --> CAT

    CAT --> SORT["Sort BAM"]
    SORT --> TYPER["Typer"]

    TYPER --> FINAL["Finalizer"]
    FQ1 --- FINAL
    FQ2 --- FINAL
    FQ3 --- FINAL
    FQ4 --- FINAL

    linkStyle 28 stroke:#FF4500, stroke-width:2px, stroke-dasharray: 5,5
    linkStyle 29 stroke:#FF4500, stroke-width:2px, stroke-dasharray: 5,5
    linkStyle 30 stroke:#FF4500, stroke-width:2px, stroke-dasharray: 5,5
    linkStyle 31 stroke:#FF4500, stroke-width:2px, stroke-dasharray: 5,5
    style B fill:none,stroke:#333,stroke-dasharray:5.5,stroke-width:2px

```
