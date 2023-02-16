rule spades:
    input:
        r1_filtered=get_trimmed_r1,
        r2_filtered=get_trimmed_r2
    output:
        contigs="results/spades_out/{sample}/contigs.fasta",
        scaffolds="results/spades_out/{sample}/scaffolds.fasta"
    params:
        out_dir=directory("results/spades_out/{sample}")
    threads: 25
    resources:
        mem="200g",
        time="20:00:00"
    shell:
        """
        module load python/3.8.4
        python /home/mmf8608/programs/spades/SPAdes-3.15.4-Linux/bin/spades.py \
        -1 {input.r1_filtered} -2 {input.r2_filtered} -o {params.out_dir} \
        -t {threads} -m 200 --meta
        """
