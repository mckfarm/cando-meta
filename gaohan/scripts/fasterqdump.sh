#!/bin/sh
#SBATCH -A p31629
#SBATCH -p normal
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 4:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="fasterq_dump"
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module load sratoolkit

cd /projects/b1052/mckenna/cando-meta/gaohan/raw_reads

# fasterq-dump --split-3 SRR5576001
fasterq-dump --split-3 SRR5576002
fasterq-dump --split-3 SRR5576003
fasterq-dump --split-3 SRR5576004
fasterq-dump --split-3 SRR5576005