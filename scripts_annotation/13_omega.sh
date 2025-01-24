#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="omega"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__omega%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__omega%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/omega
COPIA_ALL=/data/users/hkamdoumkemfio/transcriptome_assembly/output/concatenate/Copia_RT_all.fasta
GYPSY_ALL=/data/users/hkamdoumkemfio/transcriptome_assembly/output/concatenate/Gypsy_RT_all.fasta

mkdir -p $OUTPUT
cd $OUTPUT

# Load the Clustal Omega module
module load Clustal-Omega/1.2.4-GCC-10.3.0

# Align the Copia AND GYPSY sequences
clustalo -i $COPIA_ALL -o $OUTPUT/copia_prot_align.fasta
clustalo -i $GYPSY_ALL -o $OUTPUT/gypsy_prot_align.fasta
