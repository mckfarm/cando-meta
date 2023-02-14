rule fastqc_raw:
    input: 
        r1 = get_r1,
        r2 = get_r2
    output:
        "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r1_fastqc.html",
        "results/fastqc_out/raw_qc/{sample}/{sample}.fastp.r2_fastqc.html",
    params:
        out_dir = "results/fastqc_out/raw_qc/{sample}"
    threads: 1
    shell:
        """
        mkdir -p {params.out_dir}
        module load fastqc/0.11.5
        fastqc -t {threads} {input.r1} {input.r2} --outdir {params.out_dir}
        """

rule fastqc_filt:
    input: 
        get_trimmed_r1,
        get_trimmed_r2,
    output:
        "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r1_fastqc.html",
        "results/fastqc_out/fastp_qc/{sample}/{sample}.fastp.r2_fastqc.html",
    params:
        out_dir = "results/fastqc_out/fastp_qc/{sample}"
    threads: 1
    shell:
        """
        mkdir -p {params.out_dir}
        module load fastqc/0.11.5
        fastqc -t {threads} {input.r1_filtered} {input.r2_filtered} --outdir {params.out_dir}
        """ 

rule fastqc_raw_multiqc:
    input:
        fastqc_reports = get_fastqc_raw_multiqc
    output:
        multiqc_report = "results/fastqc_out/raw_qc/multiqc_report.html"
    params:
        out_dir="results/fastqc_out/raw_qc/"
    shell:
        """
        module load multiqc
        multiqc --outdir {params.out_dir}
        """

rule fastqc_filt_multiqc:
    input:
        fastqc_reports = get_fastqc_filt_multiqc
    output:
        multiqc_report = "results/fastqc_out/fastp_qc/multiqc_report.html"
    params:
        out_dir="results/fastqc_out/fastp_qc/"
    shell:
        """
        module load multiqc
        multiqc --outdir {params.out_dir}
        """
