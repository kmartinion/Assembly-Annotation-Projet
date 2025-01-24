#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=samtools
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_samtools_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/error_samtools_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly
OUTDIR=$WORKDIR/output/samtools
MODULE=SAMtools/1.13-GCC-10.3.0 
ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta

mkdir -p $OUTDIR
touch $OUTDIR/flye.fai

# Load the specified SAMtools module
module load $MODULE


# Use samtools to index the FASTA assembly file

samtools faidx $ASSEMBLY --fai-idx $OUTDIR/flye.fai
