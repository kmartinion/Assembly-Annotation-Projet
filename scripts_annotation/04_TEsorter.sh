#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="TE sorter"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__TEsorter%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log//output__TEsorter%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.fa
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/TEsorter

mkdir -p $OUTPUT
cd $OUTPUT

# Execute TEsorter using a apptainer container

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $WORKDIR -db rexdb-plant

