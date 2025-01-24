#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="prep genspace"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespace_prep%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespace_prep%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/GeneSpace_Prep
ASSEMBLY=/data/users/hkamdoumkemfio/transcriptome_assembly/output/samtools/flye.fai
Accession="Istisu-1"
PROTEINS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
mkdir -p $OUTPUT
cd $OUTPUT

#get 20 most long contigs
cut -f1,2 $ASSEMBLY | sort -k2,2nr | head -n 20 | cut -f1 > identified_contigs
#get gene positions of 20 longest contigs with their gene names
grep -Ff identified_contigs $GFF | awk -F '\t' '$3 == "gene" {match($9, /ID=([^;]+)/, arr); gene_name = arr[1]; print $1, $4-1, $5, gene_name}' OFS='\t' > ${Accession}.bed
#get gene names for all matching contigs in gene_ids and extract seqs from proteins fasta file
awk '{print $4}' ${Accession}.bed > gene_ids.txt
grep -A1 -Ff gene_ids.txt $PROTEINS | sed '/^--$/d' > ${Accession}.fa
#moving to genespace folder
mv Istisu-1.bed ../genespace/bed/
mv Istisu-1.fa ../genespace/peptide/
