#!/usr/bin/env bash

#SBATCH --cpus-per-task=4  # Augmentation des CPU pour une meilleure performance
#SBATCH --mem=10G           # Augmentation de la mémoire pour mieux gérer les données
#SBATCH --time=05-00:00:00   # Temps plus long pour s'assurer que le travail se termine
#SBATCH --job-name=clades   # Nom du job
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_clades_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/error_clades_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR  
IMAGE=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif    
WORKDIR=$OUTDIR/assembly.fasta.mod.LTR.intact.fa.ori.dusted  
mkdir -p $OUTDIR
cd $OUTDIR

# Execute the TEsorter tool within the apptainer container
apptainer exec \
 --bind /data:/data $IMAGE \
 TEsorter $WORKDIR -db rexdb-plant -p 20
