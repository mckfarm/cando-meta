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
        all_rules.append("results/quast_out/spades/report.html")

    if config["ASSEMBLYPARSE"]: 
        all_rules = all_rules + expand(
            "results/spades_parse/{sample}/{sample}.scaffolds.trim.fasta",
            sample=sample_sheet["sample_name"]
        )
        
        all_rules = all_rules + expand(
            "results/spades_parse/{sample}/{sample}_sorted.bam",
            sample=sample_sheet["sample_name"]
        )
        
        all_rules = all_rules + expand(
            "results/spades_parse/{sample}/{sample}.sam",
            sample=sample_sheet["sample_name"]
        )        

        all_rules = all_rules + expand(
            "results/spades_parse/{sample}/{sample}.stats.txt",
            sample=sample_sheet["sample_name"]
        )

        all_rules = all_rules + expand(
            "results/spades_parse/{sample}/{sample}.hist.txt",
            sample=sample_sheet["sample_name"]
        )

    if config["METABAT"]:
        metabat_results = directory(expand(
            "results/metabat_out/{sample}/bins", 
            sample=sample_sheet["sample_name"]))

        all_rules = all_rules + metabat_results

        checkm_results = directory(expand(
            "results/checkm/{sample}", 
            sample=sample_sheet["sample_name"])) 

        all_rules = all_rules + checkm_results

    if config["TAXONOMY"]: 
        all_rules = all_rules + expand(
            "results/taxonomy/metaphlan/{sample}/{sample}_profiled_metagenome.txt",
            sample=sample_sheet["sample_name"]
        )

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


# spades assembly 

def get_assembly(wildcards):
    return "results/spades_out/{sample}/scaffolds.fasta"


# quast can take a whole list of assemblies to make an output
def get_assembly_quast(wildcards):
    assembly = expand(
        "results/spades_out/{sample}/scaffolds.fasta",
        sample=sample_sheet["sample_name"])
    return assembly



# assembly parsing calls

def get_assembly_trim(wildcards):
    return "results/spades_parse/{sample}/{sample}.scaffolds.trim.fasta"

def get_sorted_bam(wildcards):
    return "results/spades_parse/{sample}/{sample}_sorted.bam"

