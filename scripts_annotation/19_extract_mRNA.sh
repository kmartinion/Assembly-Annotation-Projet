#!/usr/bin/env bash

#SBATCH --time=20:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="extract mRNA"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_extract%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_extract%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA
PROTEIN_RENAME=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename/assembly.all.maker.proteins.fasta.renamed.fasta
TRANSCRIPT_RENAME=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename/assembly.all.maker.transcripts.fasta.renamed.fasta
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
mkdir -p $OUTPUT
cd $OUTPUT

# Load UCSC Utilities, which includes `faSomeRecords`
module load UCSC-Utils/448-foss-2021a

# Load MariaDB, though it's not directly used in this script
module load MariaDB/10.6.4-GCC-10.3.0



# Step 1: Extract names of remaining mRNAs from the GFF3 file
grep -P "\tmRNA\t" /data/users/hkamdoumkemfio/transcriptome_assembly/output/AED/filtered.genes.renamed.final.gff3 \
| awk '{print $9}' \
| cut -d ';' -f1 \
| sed 's/ID=//g' >mRNA_list.txt

# Step 2: Extract transcripts corresponding to the mRNA IDs
faSomeRecords $TRANSCRIPT_RENAME mRNA_list.txt ${transcript}.renamed.filtered.fasta

# Step 3: Extract proteins corresponding to the mRNA IDs
faSomeRecords $PROTEIN_RENAME mRNA_list.txt ${protein}.renamed.filtered.fasta


