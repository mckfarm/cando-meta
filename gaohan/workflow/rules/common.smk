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

        all_rules.append("results/fastqc_out/raw_qc/multiqc_report.html")

        all_rules.append("results/fastqc_out/fastp_qc/multiqc_report.html")


    if config["NONPAREIL"]:
        all_rules = all_rules + expand(
            "results/nonpareil_out/{sample}/{sample}.r1.npo",
            sample=sample_sheet["sample_name"]
        )
        all_rules = all_rules + expand(
            "results/nonpareil_out/{sample}/{sample}.r2.npo",
            sample=sample_sheet["sample_name"]
        )
    
    if config["SPADES"]:
        all_rules = all_rules + expand(
            "results/spades_out/{sample}/scaffolds.fasta",
            sample=sample_sheet["sample_name"]
        )

    if config["ASSEMBLYQC"]: 
        all_rules = all_rules + expand(
            "results/quast_out/spades/{sample}/report.html",
            sample=sample_sheet["sample_name"]
        )

        all_rules.append("results/quast_out/multiqc_report.html")

    return all_rules


# Helper functions for getting initial reads
# sample sheet
def get_read_path(wildcards):
    return sample_sheet.loc[wildcards.sample, ["accession", "sample_name", "forward", "reverse"]].dropna()

# raw reads
def get_r1(wildcards):
    tmp = get_read_path(wildcards)
    return tmp["forward"]

def get_r2(wildcards):
    tmp = get_read_path(wildcards)
    return tmp["reverse"]

# fastp outputs
def get_trimmed_r1(wildcards):
    return "results/fastp_out/{sample}/{sample}.fastp.r1.fastq.gz"

def get_trimmed_r2(wildcards):
    return "results/fastp_out/{sample}/{sample}.fastp.r2.fastq.gz"

# spades assembly
def get_assembly(wildcards):
    return "results/spades_out/{sample}/scaffolds.fasta"

# multiqc reports
def get_fastqc_raw_multiqc(wildcards):
    fastqc_reports =[]

    fastqc_reports = fastqc_reports + expand(
       "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r1_fastqc.html", 
        sample=sample_sheet["sample_name"])
    fastqc_reports = fastqc_reports + expand(
       "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r2_fastqc.html", 
        sample=sample_sheet["sample_name"])

    return fastqc_reports

def get_fastqc_filt_multiqc(wildcards):
    fastqc_reports =[]

    fastqc_reports = fastqc_reports + expand(
       "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r1_fastqc.html", 
        sample=sample_sheet["sample_name"])
        
    fastqc_reports = fastqc_reports + expand(
       "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r2_fastqc.html", 
        sample=sample_sheet["sample_name"])

    return fastqc_reports


def get_quast_multiqc(wildcards):
    quast_reports = expand(
       "results/quast_out/spades/{sample}/report.html", 
        sample=sample_sheet["sample_name"])
    return quast_reports

