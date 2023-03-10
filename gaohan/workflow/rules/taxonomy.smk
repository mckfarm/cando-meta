rule metaphlan:
    input:
        r1_clean = get_trimmed_r1,
        r2_clean = get_trimmed_r2
    output:
        table = "results/taxonomy/metaphlan/{sample}/{sample}_profiled_metagenome.txt",
        bowtie = "results/taxonomy/metaphlan/{sample}/{sample}_bowtie2.bz2"
    threads: 5
    shell:
        """
        module load metaphlan/4.0.1
        metaphlan {input.r1_clean},{input.r2_clean} \
        --input_type fastq -o {output.table} --bowtie2out {output.bowtie} \
        --bowtie2db resources/metaphlan_db --index mpa_vOct22_CHOCOPhlAnSGB_202212 \
        --nproc {threads} 
        """

def metaphlan_merge_inputs(wildcards):
    files = expand("results/taxonomy/metaphlan/{sample}/{sample}_profiled_metagenome.txt",
        sample=sample_sheet["sample_name"])
    return files

rule metaphlan_merge:
    input:
        metaphlan_merge_inputs
    output:
        "results/taxonomy/merged_metaphlan_profile.tsv"
    shell:
        """
        module load anaconda3/2022.05
        scripts/merge_metaphlan_tables.py {input} > {output}
        """

# rule mmseqs:
#     input:
#         bam_sorted = get_sorted_bam,
#         contigs = get_assembly_trim,
#         bam_index = "results/spades_parse/{sample}/{sample}_sorted.bam.bai"
#     output:
#         depth_fi = "results/taxonomy/mmseqs/{sample}/{sample}_depth.txt"
#     conda:
#         "../envs/mmseqs.yaml"
#     threads: 12
#     shell:
#         """
#         jgi_summarize_bam_contig_depths \
#         --outputDepth {output.depth_fi} \
#         --percentIdentity 97 \
#         --minContigLength 1000 \
#         --minContigDepth 1.0 \
#         --referenceFasta {input.contigs} {input.bam_sorted}
#         """
