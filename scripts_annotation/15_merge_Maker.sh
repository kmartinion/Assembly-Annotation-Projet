#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Merge_maker"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_Merge_Maker%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_Merge_Maker%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/merge_maker
DATASTORE_INDEX=/data/users/hkamdoumkemfio/transcriptome_assembly/output/MAKER/assembly.maker.output/assembly_master_datastore_index.log
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN=$COURSEDIR/softwares/Maker_v3.01.03/src/bin
mkdir -p $OUTPUT
cd $OUTPUT

# Merge MAKER output GFF3 files (with sequences)
$MAKERBIN/gff3_merge -s -d $DATASTORE_INDEX > assembly.all.maker.gff 
# Merge MAKER output GFF3 files (without sequences)
$MAKERBIN/gff3_merge -n -s -d $DATASTORE_INDEX > assembly.all.maker.noseq.gff
# Merge FASTA sequences from MAKER output
$MAKERBIN/fasta_merge -d $DATASTORE_INDEX -o assembly


