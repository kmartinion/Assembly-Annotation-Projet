#!/usr/bin/env bash
#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=edta
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_edta_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/error_edta_%j.e
#SBATCH --partition=pibu_el8


# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/EDTA_annotation
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT
cd $OUTPUT

#  Run EDTA 
apptainer exec --bind /usr/bin/which:/usr/bin/which --bind /data /data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif EDTA.pl --genome $WORKDIR --species others --step all --cds /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated --anno 1 --threads $THREADS
