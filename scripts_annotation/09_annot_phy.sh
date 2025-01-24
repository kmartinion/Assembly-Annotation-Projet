#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="annot_phylo"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_annot_pylo_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_annot_pylo_%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/annot_phylo
COPIA=/data/users/hkamdoumkemfio/transcriptome_assembly/output/seqKit/Copia_sequences.fa.rexdb-plant.dom.faa
GYPSY=/data/users/hkamdoumkemfio/transcriptome_assembly/output/seqKit/Gypsy_sequences.fa.rexdb-plant.dom.faa

mkdir -p $OUTPUT
cd $OUTPUT

# Load the SeqKit module
module load SeqKit/2.6.1

#Copia
grep Ty1-RT $COPIA > list_copia.txt #make a list of RT proteins to extract
sed -i 's/>//' list_copia.txt #remove ">" from the header
sed -i 's/ .\+//' list_copia.txt #remove all characters following "empty space" from the header
seqkit grep -f list_copia.txt $COPIA -o Copia_RT.fasta

#Gypsy
grep Ty3-RT $GYPSY > list_gypsy.txt #make a list of RT proteins to extract
sed -i 's/>//' list_gypsy.txt #remove ">" from the header
sed -i 's/ .\+//' list_gypsy.txt #remove all characters following "empty space" from the header
seqkit grep -f list_gypsy.txt $GYPSY -o Gypsy_RT.fasta
