from snakemake.utils import validate
import pandas as pd

# sample sheet 
sample_sheet = pd.read_csv(config["sample_sheet"]).set_index("sample_name", drop=False)
sample_sheet.index.names = ["sample_name"]


# Parse config file to determine output for rule all 
def get_rules(wildcards):
    all_rules = []

    if config["FASTP"]:
        all_rules = all_rules + expand(
            "results/fastp_out/{sample}/{sample}.fastp.r1.fastq.gz", 
            sample=sample_sheet["sample_name"]
        )

        all_rules = all_rules + expand(
            "results/fastp_out/{sample}/{sample}.fastp.r2.fastq.gz", 
            sample=sample_sheet["sample_name"] 
        )

    if config["FASTQC"]:
        all_rules = all_rules + expand(
            "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r1_fastqc.html", 
            sample=sample_sheet["sample_name"]
        )
        all_rules = all_rules + expand(
            "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r2_fastqc.html", 
            sample=sample_sheet["sample_name"]
        )
        all_rules = all_rules + expand(
            "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r1_fastqc.html", 
            sample=sample_sheet["sample_name"]
        )
        all_rules = all_rules + expand(
            "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r2_fastqc.html", 
            sample=sample_sheet["sample_name"]
        )

    if config["NONPAREIL"]:
        all_rules = all_rules + expand(
            "results/nonpareil_out/{sample}/{sample}.r1.npo",
            sample=sample_sheet["sample_name"]
        )
        all_rules = all_rules + expand(
            "results/nonpareil_out/{sample}/{sample}.r2.npo",
            sample=sample_sheet["sample_name"]
        )

    return all_rules


# Helper functions for getting initial reads
def get_read_path(wildcards):
    return sample_sheet.loc[wildcards.sample, ["accession", "sample_name", "forward", "reverse"]].dropna()

def get_r1(wildcards):
    tmp = get_read_path(wildcards)
    return tmp["forward"]

def get_r2(wildcards):
    tmp = get_read_path(wildcards)
    return tmp["reverse"]


