# Snakemake metagenomics pipeline

This pipeline is an update to my [previous metagenomics pipeline](https://github.com/mckfarm/metagenomics) for the Wells Lab. This pipeline uses [Snakemake](https://snakemake.readthedocs.io/en/stable/), a Python-based workflow management system that is great for making reproducible computational workflows. Endless thanks to [Jack Sumner](https://github.com/jtsumner) whose [MLM pipeline](https://github.com/jtsumner/mlm) is the foundation of this work.  

Unlike my previous pipeline, which used a series of separate bash scripts calling multiple programs, the Snakemake framework allows for all inputs, outputs, and programs to be accounted for in one place. Snakemake offers some key benefits over more basic pipeline systems:
- Snakemake can check for workflow-wide inputs and outputs, allowing you to run an entire analysis pipeline made up of different software where inputs and outputs feed into eachother
- Conda installations can be managed entirely by Snakemake, letting you keep track of version numbers and environments without cluttering your working directories
- Snakemake can execute custom Python functions and scripts seamlessly 

The Snakemake approach has some drawbacks, primarily the learning curve to get started. Configuring a Snakemake workflow involves working between 3-4 files at a time and requires a working knowledge of Python, particularly in writing functions for file I/O. That said, I have found that the Snakemake workflow system is much easier to work with overall, requiring much less time spent on configuring conda environments and keeping multiple bash scripts updated after upstream edits. 


This repo is a work in progress...


# Workflow
1. Raw read trimming (fastp)
2. Raw and trimmed read QC (fastqc), trimmed read coverage estimate (nonpareil)
3. Assembly (spades)
4. Assembly QC (assembly_qc - quast)
5. Assembly cleanup and prep for binning (assembly_parse - bbmap)
6. Binning (metabat)




