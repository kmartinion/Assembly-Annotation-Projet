#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --time=05:00:00
#SBATCH --job-name=maker-control-files
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_maker-control-files_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/error_maker-control-files_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/
OUTDIR=$WORKDIR/output/MAKER
IMAGE=/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif
mkdir -p $OUTDIR
cd $OUTDIR

# Execute the MAKER tool within the apptainer container
apptainer exec --bind $OUTDIR \
    $IMAGE maker -CTL
