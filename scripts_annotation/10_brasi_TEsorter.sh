#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="brasi_TEsorter"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_brasi_TE_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_brasi_TE_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/brasi_TEsorter
WORKDIR=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta
mkdir -p $OUTPUT
cd $OUTPUT

# Execute TEsorter using apptainer
apptainer exec \
    --bind /data \
    --writable-tmpfs \
    -u \
    /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
    TEsorter $WORKDIR -db rexdb-plant
