rule metabat_depth:
    input:
        bam_sorted = get_sorted_bam,
        contigs = get_assembly_trim,
        bam_index = "results/spades_parse/{sample}/{sample}_sorted.bam.bai"
    output:
        depth_fi = "results/metabat_out/{sample}/{sample}_depth.txt"
    conda:
        "../envs/metabat.yaml"
    threads: 12
    shell:
        """
        jgi_summarize_bam_contig_depths \
        --outputDepth {output.depth_fi} \
        --percentIdentity 97 \
        --minContigLength 1000 \
        --minContigDepth 1.0 \
        --referenceFasta {input.contigs} {input.bam_sorted}
        """

rule metabat_bin:
    input:
        contigs = get_assembly_trim,
        depth_fi = "results/metabat_out/{sample}/{sample}_depth.txt"
    output:
        bin_dir = directory("results/metabat_out/{sample}/bins")
    conda:
        "../envs/metabat.yaml"
    threads: 6
    resources:
        mem="10g",
        time="01:00:00"
    shell:
        """
        metabat2 -t {threads} \
            --inFile {input.contigs} \
            --outFile {output.bin_dir}/bin \
            --minContig 1500 \
            --abdFile {input.depth_fi} \
            --seed=100 \
            --unbinned
        """