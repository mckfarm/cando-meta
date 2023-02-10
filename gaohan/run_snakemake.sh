#! /bin/bash
#SBATCH -A p31629
#SBATCH --job-name="scheduler"
#SBATCH -t 6:00:00
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -p normal
#SBATCH --mem=20gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mckennafarmer2023@u.northwestern.edu
#SBATCH --output="slurm.out"


cd $SLURM_SUBMIT_DIR

# Annotating the output file
START_TIME=$(date)
echo "
NEW SNAKEMAKE EXECUTION :)
Job Details
Job ID: ${SLURM_JOB_ID}
Start Time: ${START_TIME}
Loading conda...
"

# Load Conda Environment with Snakemake
module purge all
module load mamba
which mamba
mamba activate snakemake

# Execute snakemake
echo "Starting snakemake on cluster..."
snakemake -c1 --use-conda

# Annotating the output file
END_TIME=$(date)
echo "
ENDING SNAKEMAKE EXECUTION
Bye-bye :)
"