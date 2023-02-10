#!/bin/sh
#SBATCH -A p31629
#SBATCH -p normal
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 24:00:00
#SBATCH --mem=10gb
#SBATCH --job-name="gzip"
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --mail-type=BEGIN,END,FAIL


gzip -r /projects/b1052/mckenna/cando-meta/gaohan/raw_reads

