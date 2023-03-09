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
        bam = "results/spades_parse/{sample}/{sample}.bam",
        sort_bam_script = "results/spades_parse/{sample}/bs.sh",
        sorted_bam = "results/spades_parse/{sample}/{sample}_sorted.bam"
    params:
        index_path = directory("results/spades_parse/{sample}/")
    priority: 4
    resources:
        mem="36gb",
        time="15:00:00",
        threads=6
    shell:
        """
        module load samtools/1.10.1
        bash /home/mmf8608/programs/bbmap_39.01/bbmap.sh \
        in={input.r1_filtered} in2={input.r2_filtered} t={resources.threads} \
        out={output.bam} ref={input.assembly_trimmed} path={params.index_path} \
        bamscript={output.sort_bam_script}; sh {output.sort_bam_script}
        """

rule make_sam:
    input:
        bam = "results/spades_parse/{sample}/{sample}.bam"
    output:
        sam = "results/spades_parse/{sample}/{sample}.sam"
    params:
        index_path = directory("results/spades_parse/{sample}/")
    resources:
        mem="20gb",
        time="05:00:00"
    shell:
        """
        module load samtools/1.10.1
        samtools view -h -o {output.sam} {input.bam}
        """

rule assembly_coverage:
    input:
        sorted_bam = get_sorted_bam
    output:
        coverage_stats = "results/spades_parse/{sample}/{sample}.stats.txt",
        coverage_hist = "results/spades_parse/{sample}/{sample}.hist.txt"
    resources:
        mem="5gb",
        time="01:00:00"
    shell:
        """
        module load samtools/1.10.1
        bash /home/mmf8608/programs/bbmap_39.01/pileup.sh \
        in={input.sorted_bam} out={output.coverage_stats} hist={output.coverage_hist}
        """
