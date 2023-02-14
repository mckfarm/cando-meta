rule nonpareil:
    input:
        get_trimmed_r1,
        get_trimmed_r2,
    output:
        tmp_fastq = temp("results/nonpareil_out/{sample}/{sample}.tmp"),
        pareil_r1 = "results/nonpareil_out/{sample}/{sample}.r1.npo",
        pareil_r2 = "results/nonpareil_out/{sample}/{sample}.r2.npo",
    params:
        out_dir = "results/nonpareil_out/{sample}/"
    resources:
        mem="20G"
    shell:
        """
        mkdir -p {params.out_dir}
        module load nonpareil/3.4.1

        gunzip -c {input.r1_filtered} > {output.tmp_fastq}
        nonpareil -s {output.tmp_fastq} -T kmer -f fastq -b {params.out_dir} -t 1

        gunzip -c {input.r2_filtered} > {output.tmp_fastq}
        nonpareil -s {output.tmp_fastq} -T kmer -f fastq -b {params.out_dir} -t 1
        """