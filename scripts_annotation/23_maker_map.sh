#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="map_maker"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_map_maker%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_map_maker%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/map_maker
MAKER_PROTEINS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
UNIPROT=$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa
PROTEINS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=/data/users/hkamdoumkemfio/transcriptome_assembly/output/AED/filtered.genes.renamed.gff3
BLAST=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Blast/maker_proteins_blastp_output

mkdir -p $OUTPUT
cd $OUTPUT

# Copy the input protein FASTA and GFF3 files to the output directory for processing
cp $PROTEINS $OUTPUT/maker_proteins.fasta.Uniprot
cp $FILTERED $OUTPUT/filtered.maker.gff3.Uniprot

# Update the functional annotations in the protein FASTA file
$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST $PROTEINS > $OUTPUT/maker_proteins.fasta.Uniprot

# Update the functional annotations in the GFF3 file
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST $FILTERED > $OUTPUT/filtered.maker.gff3.Uniprot
