#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_fastp_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_fastp_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/
OUTDIR=$WORKDIR/read_QC/fastp

mkdir -p $OUTDIR

# Add the modules
module load fastp/0.23.4-GCC-10.3.0

 # Run the quality analysis

fastp -i $WORKDIR/Istisu-1/*  -o $OUTDIR/pacbio_trimmed.fastq.gz -h $OUTDIR/pacbio.html
fastp -i $WORKDIR/RNAseq_Sha/*1* -I $WORKDIR/RNAseq_Sha/*2*  -o $OUTDIR/short_1.fastq.gz -O $OUTDIR/short_2.fastq.gz -q 20 -h $OUTDIR/short.html

