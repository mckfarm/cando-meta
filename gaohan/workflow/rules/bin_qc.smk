rule checkm:
    input:
        bin_dir = "results/metabat_out/{sample}/bins"
    output:
        checkm_dir = directory("results/checkm/{sample}"),
        checkm_fi = "results/checkm/{sample}/{sample}_checkm_output.txt"
    threads: 12
    resources:
        mem="40g"
    shell:
        """
        module load checkm/1.0.7
        checkm lineage_wf \
        --threads {threads} \
        --extension 'fa' \
        --file {output.checkm_fi} --tab_table \
        {input.bin_dir} {output.checkm_dir}
        """

# rule bin_filter:
#     input:
#         checkm_fi = "results/checkm/{sample}/{sample}_checkm_output.txt"
#     output:
#         checkm_dir = directory("results/checkm/{sample}"),
#         checkm_fi = "results/checkm/{sample}/{sample}_checkm_output.txt"
#     shell:
#         """
#         module load checkm/1.0.7
#         checkm lineage_wf \
#         --threads {threads} \
#         --extension 'fa' \
#         --file {output.checkm_fi} \
#         {input.bin_dir} {output.checkm_dir}
#         """

