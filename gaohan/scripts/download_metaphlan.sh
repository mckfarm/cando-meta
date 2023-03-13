#! /bin/bash
#SBATCH -A b1042
#SBATCH --job-name="scheduler"
#SBATCH -t 24:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p genomicsguest
#SBATCH --mem=5Gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output="download.out"


cd /projects/b1052/mckenna/cando-meta/gaohan/resources/metaphlan_db

wget http://cmprod1.cibio.unitn.it/biobakery4/metaphlan_databases/bowtie2_indexes/mpa_vOct22_CHOCOPhlAnSGB_202212_bt2.tar
tar –xvf mpa_vOct22_CHOCOPhlAnSGB_202212_bt2.tar