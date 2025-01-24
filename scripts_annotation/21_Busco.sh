#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Busco"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/busco%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/busco%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Busco
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
mkdir -p $OUTPUT
cd $OUTPUT

# Load the BUSCO module
module load BUSCO/5.4.2-foss-2021a

# Run BUSCO to assess the completeness of the protein sequences
busco -i $WORKDIR -l brassicales_odb10 -o $OUTPUT -m proteins