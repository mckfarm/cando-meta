#!/bin/sh
# properties = {"type": "single", "rule": "spades", "local": false, "input": ["results/fastp_out/gao4/gao4.fastp.r1.fastq.gz", "results/fastp_out/gao4/gao4.fastp.r2.fastq.gz"], "output": ["results/spades_out/gao4/scaffolds.fasta"], "wildcards": {"sample": "gao4"}, "params": {"out_dir": "results/spades_out/gao4"}, "log": [], "threads": 25, "resources": {"mem_mb": 100000, "mem_mib": 20714, "disk_mb": 21720, "disk_mib": 20714, "tmpdir": "<TBD>", "account": "p31629", "partition": "normal", "nodes": 1, "threads": 12, "mem": "100g", "time": "10:00:00"}, "jobid": 7, "cluster": {}}
cd '/projects/b1052/mckenna/cando-meta/gaohan' && /home/mmf8608/.conda/envs/snakemake/bin/python3.11 -m snakemake --snakefile '/projects/b1052/mckenna/cando-meta/gaohan/workflow/Snakefile' --target-jobs 'spades:sample=gao4' --allowed-rules 'spades' --cores 'all' --attempt 1 --force-use-threads  --resources 'mem_mb=100000' 'mem_mib=20714' 'disk_mb=21720' 'disk_mib=20714' 'nodes=1' 'threads=12' --wait-for-files '/projects/b1052/mckenna/cando-meta/gaohan/.snakemake/tmp.wjziey61' 'results/fastp_out/gao4/gao4.fastp.r1.fastq.gz' 'results/fastp_out/gao4/gao4.fastp.r2.fastq.gz' --force --keep-target-files --keep-remote --max-inventory-time 0 --nocolor --notemp --no-hooks --nolock --ignore-incomplete --rerun-triggers 'code' 'mtime' 'software-env' 'params' 'input' --skip-script-cleanup  --use-conda  --conda-frontend 'mamba' --conda-base-path '/software/miniconda3/mamba-0.15.3' --wrapper-prefix 'https://github.com/snakemake/snakemake-wrappers/raw/' --printshellcmds  --latency-wait 60 --scheduler 'greedy' --scheduler-solver-path '/home/mmf8608/.conda/envs/snakemake/bin' --default-resources 'mem_mb=max(2*input.size_mb, 1000)' 'disk_mb=max(2*input.size_mb, 1000)' 'tmpdir=system_tmpdir' 'account="p31629"' 'partition="normal"' 'nodes=1' 'threads=12' 'mem="100G"' 'time="10:00:00"' --mode 2 && touch '/projects/b1052/mckenna/cando-meta/gaohan/.snakemake/tmp.wjziey61/7.jobfinished' || (touch '/projects/b1052/mckenna/cando-meta/gaohan/.snakemake/tmp.wjziey61/7.jobfailed'; exit 1)

