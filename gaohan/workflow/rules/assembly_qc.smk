rule quast_spades:
    input:
        get_assembly
    output:
        report="results/quast_out/spades/{sample}/report.html"
    params:
        out_dir="results/quast_out/spades/{sample}"
    threads: 1
    shell:
        """
        module load python/3.8.4
        python /home/mmf8608/programs/quast/quast-5.2.0/quast.py \
        -o {params.out_dir} --threads {threads} --min-contig 500 -L {input}
        """

rule quast_multiqc:
    input:
        quast_reports = get_quast_multiqc
    output:
        multiqc_report = "results/quast_out/multiqc_report.html"
    params:
        out_dir="results/quast_out"
    shell:
        """
        module load multiqc
        multiqc --outdir {params.out_dir}
        """
