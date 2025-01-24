#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_fastqc_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/
OUTDIR=$WORKDIR/read_QC/fastqc

mkdir -p $OUTDIR

# Add the modules

module load FastQC/0.11.9-Java-11

# Make the quality analysis


fastqc -o $OUTDIR --extract $WORKDIR/Istisu-1/* $WORKDIR/RNAseq_Sha/*

