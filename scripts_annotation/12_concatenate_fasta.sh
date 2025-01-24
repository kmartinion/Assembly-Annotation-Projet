#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="concatenate"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_concatenate__%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_concatenate__%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/concatenate
WORKDIR_TY1=/data/users/hkamdoumkemfio/transcriptome_assembly/output/brasiPhylo/Brassica_TY1_RT.fasta
WORKDIR_TY3=/data/users/hkamdoumkemfio/transcriptome_assembly/output/brasiPhylo/Brassica_TY3_RT.fasta
COPIA=/data/users/hkamdoumkemfio/transcriptome_assembly/output/annot_phylo/Copia_RT.fasta
GYPSY=/data/users/hkamdoumkemfio/transcriptome_assembly/output/annot_phylo/Gypsy_RT.fasta

mkdir -p $OUTPUT
cd $OUTPUT

# Concatenate Ty1/Copia sequences
cat $WORKDIR_TY1 $COPIA > Copia_RT_all.fasta
# Concatenate Ty3/Gypsy sequences
cat $WORKDIR_TY3 $GYPSY > Gypsy_RT_all.fasta

# Remove comments and modify sequence headers for Copia
sed -i 's/#.\+//' Copia_RT_all.fasta 
sed -i 's/:/_/g' Copia_RT_all.fasta

# Remove comments and modify sequence headers for Gypsy
sed -i 's/#.\+//' Gypsy_RT_all.fasta
sed -i 's/:/_/g' Gypsy_RT_all.fasta
