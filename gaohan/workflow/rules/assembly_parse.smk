rule assembly_trim:
    input:
        assembly = get_assembly
    output:
        assembly_trimmed = "results/spades_parse/{sample}/{sample}.scaffolds.trim.fasta"
    priority: 5
    shell:
        """
        bash /home/mmf8608/programs/bbmap_39.01/reformat.sh \
        in={input.assembly} out={output.assembly_trimmed} \
        minlength=3000
        """

rule make_bam:
    input:
        r1_filtered = get_trimmed_r1, 
        r2_filtered = get_trimmed_r2,
        assembly_trimmed = get_assembly_trim
    output:
        sorted_bam = "results/spades_parse/{sample}/{sample}.sorted.bam",
        sort_bam_script = "results/spades_parse/{sample}/bs.sh"
    params:
        index_path = directory("results/spades_parse/{sample}/")
    priority: 4
    resources:
        mem="20gb",
        time="05:00:00"
    shell:
        """
        module load samtools/1.10.1
        bash /home/mmf8608/programs/bbmap_39.01/bbmap.sh \
        in={input.r1_filtered} in2={input.r2_filtered} \
        out={output.sorted_bam} ref={input.assembly_trimmed} path={params.index_path} \
        bamscript={output.sort_bam_script}; sh {output.sort_bam_script}
        """

rule index_map:
    input:
        assembly_trimmed = get_assembly_trim,
        r1_filtered = get_trimmed_r1, 
        r2_filtered = get_trimmed_r2
    output:
        mapped_sam = "results/spades_parse/{sample}/{sample}.mapped.sam"
    params:
        index_path = directory("results/spades_parse/{sample}/")
    resources:
        mem="20gb",
        time="05:00:00"
    shell:
        """
        module load samtools/1.10.1
        bash /home/mmf8608/programs/bbmap_39.01/bbmap.sh \
        in={input.r1_filtered} in2={input.r2_filtered} \
        ref={input.assembly_trimmed} path={params.index_path} out={output.mapped_sam}
        """

rule assembly_coverage:
    input:
        mapped_sam = "results/spades_parse/{sample}/{sample}.mapped.sam"
    output:
        coverage_stats = "results/spades_parse/{sample}/{sample}.stats.txt",
        coverage_hist = "results/spades_parse/{sample}/{sample}.hist.txt"
    resources:
        mem="20gb",
        time="05:00:00"
    shell:
        """
        bash /home/mmf8608/programs/bbmap_39.01/pileup.sh \
        in={input.mapped_sam} out={output.coverage_stats} hist={output.coverage_hist}
        """
