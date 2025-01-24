#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="FastTree"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_fastTree%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_fastTree%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/fastTree
COPIA_ALIGN=/data/users/hkamdoumkemfio/transcriptome_assembly/output/omega/copia_prot_align.fasta
GYPSY_ALIGN=/data/users/hkamdoumkemfio/transcriptome_assembly/output/omega/gypsy_prot_align.fasta

mkdir -p $OUTPUT
cd $OUTPUT

# Load the FastTree module
module load FastTree/2.1.11-GCCcore-10.3.0

# Build a phylogenetic tree for the aligned Copia and Gypsy sequences
FastTree -out Copia_tree $COPIA_ALIGN
FastTree -out Gypsy_tree $GYPSY_ALIGN
