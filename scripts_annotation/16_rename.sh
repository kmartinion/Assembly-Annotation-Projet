#!/usr/bin/env bash

#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Rename"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_rename%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_rename%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/merge_maker
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
protein="assembly.all.maker.proteins.fasta"
transcript="assembly.all.maker.transcripts.fasta"
gff="assembly.all.maker.noseq.gff"
prefix=istisu1

mkdir -p $OUTPUT
cd $WORKDIR

cp $gff $OUTPUT/${gff}.renamed.gff
cp $protein $OUTPUT/${protein}.renamed.fasta
cp $transcript $OUTPUT/${transcript}.renamed.fasta

cd $OUTPUT

# Step 1: Generate a mapping of original IDs to new IDs for GFF3 annotations
$MAKERBIN/maker_map_ids --prefix $prefix --justify 7 ${gff}.renamed.gff > $OUTPUT/id.map

# Step 2: Update IDs in the GFF3 file using the mapping file
$MAKERBIN/map_gff_ids id.map ${gff}.renamed.gff

# Step 3: Update IDs in the protein FASTA file using the mapping file
$MAKERBIN/map_fasta_ids id.map ${protein}.renamed.fasta

# Step 4: Update IDs in the transcript FASTA file using the mapping file
$MAKERBIN/map_fasta_ids id.map ${transcript}.renamed.fasta
