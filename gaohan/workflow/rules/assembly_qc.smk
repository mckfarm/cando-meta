rule quast_spades:
    input:
        get_assembly_quast
    output:
        report="results/quast_out/spades/report.html"
    params:
        out_dir=directory("results/quast_out/spades/")
    threads: 1
    shell:
        """
        module load python/3.8.4
        python /home/mmf8608/programs/quast/quast-5.2.0/quast.py \
        -o {params.out_dir} --threads {threads} -L {input}
        """
