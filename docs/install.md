# Installation

Starting `v0.2.0`, the recommended way to install `mhcflow` is via PyPI:

```bash
pip install mhcflow
```

!!! note
    `mhcflow` implicitly requires `samtools`, `novoalign`, and `novoindex`
    binaries to be available in your environment. Currently, `mhcflow` does not
    check for the presence of these binaries.

## Pre-v0.2.0 

Please follow the instructions below if you choose to use the `v0.1.0` version.

- Clone the `v0.1.0` branch of the `mhcflow` repository:

```bash
git clone -b v0.1.0 https://github.com/svm-zhang/mhcflow.git
```

- For those who want to build the `v0.1.0` using `boa`:
    The `boa` project has been archived, and you might want to try its
    successor `rattler-build`. However, I was unable to build the `v0.1.0`
    with `rattler-build` on both the Linux and MacOs
    (see [here](https://github.com/prefix-dev/rattler-build/issues/1459)).
    This difficulty is the primary reason I rewrote `mhcflow` in Python
    starting with `v0.2.0`.

    If you manage to get `rattler-build` working in your environment, you will
    need to take the following additional steps:

    1. Update the `recipe.yaml` in the `v0.1.0` branch to conform to
    the `rattler-build` recipe specification.
    2. Use the `rattler-build` command instead of `boa`.


- If you continue to have trouble building `mhcflow` with `rattler-build`,
please refer to the __Manual__ section in the `INSTALL.md`. Additionally,
see the runtime requirement section of `recipe.yaml` for a list of dependencies
required to run `v0.1.0`. The dependency list is illustrated below:

```text
  run:
    - python >=3.8
    - numpy
    - pysam
    - polars
    - tqdm
    - samtools >=1.13
    - picard
    - seqkit
```

!!! note
    I will provide a Dockerfile at a later point to ease the installation process.
