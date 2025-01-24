#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name=seqKit
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__seqKit%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log//output__seqKit%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/seqKit
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/EDTA_annotation/assembly.fasta.mod.EDTA.TElib.fa
mkdir -p $OUTPUT
cd $OUTPUT

# Load the SeqKit module
module load SeqKit/2.6.1

#  Extract Copia sequences from the assembly file
seqkit grep -r -p "Copia" $WORKDIR > Copia_sequences.fa

#  Extract Gypsy sequences from the assembly file
seqkit grep -r -p "Gypsy" $WORKDIR > Gypsy_sequences.fa

# Annotate copia and Gypsy sequences using TEsorter
apptainer exec \
    --bind /data \
    --writable-tmpfs \
    -u \
    /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
    TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec \
    --bind \
    /data \
    --writable-tmpfs \
    -u \
    /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
    TEsorter Gypsy_sequences.fa -db rexdb-plant
