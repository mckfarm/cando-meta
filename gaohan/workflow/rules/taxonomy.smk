rule metaphlan:
    input:
        sam = "results/spades_parse/{sample}/{sample}.sam"
    output:
        depth_fi = "results/taxonomy/metaphlan/{sample}/{sample}_profiled_metagenome.txt"
    conda:
        "../envs/mmseqs.yaml"
    threads: 5
    shell:
        """
        module load metaphlan/4.0.1
        metaphlan {input.sam} \
        --input_type sam -o profiled_metagenome.txt \
        --bowtie2db resources/metaphlan_db --index mpa_vOct22_CHOCOPhlAnSGB_202212 \
        --nproc {threads} 
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
