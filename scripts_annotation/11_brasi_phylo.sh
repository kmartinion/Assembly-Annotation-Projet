#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail
#SBATCH --mail-type=fail,end
#SBATCH --job-name="brasiPhylo"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_brasiPhylo__%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_brasiPhylo__%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/brasiPhylo
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/brasi_TEsorter/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa
mkdir -p $OUTPUT
cd $OUTPUT

# Load the SeqKit module
module load SeqKit/2.6.1

#Copia
grep Ty1-RT $WORKDIR > list_brassica_copia.txt #make a list of RT proteins to extract
sed -i 's/>//' list_brassica_copia.txt #remove ">" from the header
sed -i 's/ .\+//' list_brassica_copia.txt #remove all characters following "empty space" from the header
seqkit grep -f list_brassica_copia.txt $WORKDIR -o Brassica_TY1_RT.fasta

#Gypsy
grep Ty3-RT $WORKDIR > list_brassica_gypsy.txt #make a list of RT proteins to extract
sed -i 's/>//' list_brassica_gypsy.txt #remove ">" from the header
sed -i 's/ .\+//' list_brassica_gypsy.txt #remove all characters following "empty space" from the header
seqkit grep -f list_brassica_gypsy.txt $WORKDIR -o Brassica_TY3_RT.fasta
