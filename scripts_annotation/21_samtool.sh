#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="filterBusco"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_B_Samtools%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_B_Saamtools%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Samtools_For_Busco
PROTEINS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
TRANSCRIPTS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta
LONGEST_PROTEINS=$OUTPUT_REPO/assembly.all.maker.proteins.fasta.renamed.filtered.longest.fasta

mkdir -p $OUTPUT
cd $OUTPUT


# Load the SAMtools module
module load SAMtools/1.13-GCC-10.3.0

# Step 1: Index the protein sequences using SAMtools
samtools faidx $PROTEINS

# Step 2: Index the transcript sequences using SAMtools
samtools faidx $TRANSCRIPTS

# Step 3: Move index files to a specific directory
#mv /data/users/hkamdoumkemfio/transcriptome_assembly/output/mRNA_extract/*fai /data/users/hkamdoumkemfio/transcriptome_assembly/output/Samtools_For_Busco
#first column is the scaffold name and the 2nd column is the length of the scaffold

# Step 4: Calculate the lengths of each protein sequence and retain the longest proteins
awk '/^>/ {if (seqlen) {print seqlen}; print; seqlen=0; next} {seqlen += length($0)} END {print seqlen}' $PROTEINS | \
awk '{if($0 ~ /^>/) {name=$0} else {print name"\t"$0}}' | \
sort -k2,2nr | uniq > ${LONGEST_PROTEINS}
