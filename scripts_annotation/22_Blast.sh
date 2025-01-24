#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --time=8:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Blast"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_Blast%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_Blast%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Blast
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
mkdir -p $OUTPUT
cd $OUTPUT

# Load the BLAST+ module
module load BLAST+/2.15.0-gompi-2021a

# Run BLASTP to compare MAKER protein sequences against the UniProt database
blastp -query $MAKER_PROTEINS -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-10 -out $OUTPUT/maker_proteins_blastp_output
