#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=genespace
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespace_run_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespacea_run_%j.e

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/R_genespace
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
GENESPACE_SCRIPT=/data/users/hkamdoumkemfio/transcriptome_assembly/scripts/genespace.R
mkdir -p "$OUTPUT"
cd "$OUTPUT"

# Set local environment variables to prevent "LC" related errors
export LC_ALL=C
export LANG=C

#Execute the GeneSpace R script via Apptainer
apptainer exec --bind "$COURSEDIR" --bind "$OUTPUT" --bind "$SCRATCH:/temp" \
    "$COURSEDIR/containers/genespace_latest.sif" Rscript "$COURSEDIR/scripts/17-Genespace.R" "$OUTPUT"
