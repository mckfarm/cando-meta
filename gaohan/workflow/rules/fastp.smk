import glob
import pandas as pd
from snakemake.utils import validate


rule fastp_pe:
    input:
        r1 = get_r1,
        r2 = get_r2
    output:
        r1_filtered = "results/fastp_out/{sample}/{sample}.fastp.r1.fastq.gz",
        r2_filtered = "results/fastp_out/{sample}/{sample}.fastp.r2.fastq.gz",
        json = "results/fastp_out/{sample}/{sample}_fastp.json",
        html = "results/fastp_out/{sample}/{sample}_fastp.html"
    conda:
        "../envs/fastp.yaml"
    threads: 12
    resources:
        mem="50G"
    shell: 
        """
        fastp -i {input.r1} \
        -I {input.r2} \
        --out1 {output.r1_filtered} \
        --out2 {output.r2_filtered} \
        --detect_adapter_for_pe \
        --dedup \
        --thread {threads} \
        --length_required 50 \
        -j {output.json} \
        -h {output.html} \
        -V
        """