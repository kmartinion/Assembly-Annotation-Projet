#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="genespace folder"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespace%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_genespace%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/genespace
LONGEST=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
#LOAD MODULE 
module load MariaDB/10.6.4-GCC-10.3.0
module load UCSC-Utils/448-foss-2021a
mkdir -p $OUTPUT
mkdir -p $OUTPUT/peptide
mkdir -p $OUTPUT/bed
cd $OUTPUT

# remove "-R.*" from fasta headers of proteins, to get only gene IDs
sed 's/-R.*//' $LONGEST > genome1_peptide.fa
# filter to select only proteins of the top 20 scaffolds
faSomeRecords genome1_peptide.fa genespace_genes.txt $OUTPUT/peptide/genome1.fa
cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.bed $OUTPUT/bed/
cp /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10.fa $OUTPUT/peptide/

rm $OUTPUT/genome1_peptide.fa
#treating my output files
#capitalize genome1.fa
cat $OUTPUT/peptide/genome1.fa | tr 'a-z' 'A-Z' > $OUTPUT/peptide/genome1_cap.fa
#capitalize fourth column of genome1.bed file + \tab sep
awk '{ $4 = toupper($4); print $1 "\t" $2 "\t" $3 "\t" $4 }' $OUTPUT/bed/genome1_cap.bed > $OUTPUT/bed/genome1_capitalized.bed
#just to make sur capitalize all leter of genespace_gene.txt
cat genespace_genes.txt | tr 'a-z' 'A-Z' > genespace_genes_capitalized.txt
#rm older files