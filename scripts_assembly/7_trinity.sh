#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=trinity
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_trinity_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_trinity_%j.e
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course
OUTDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/trinity

mkdir -p $OUTDIR

# Add the modules
module load Trinity/2.15.1-foss-2021a

# Run Trinity
Trinity \
--seqType fq \
--max_memory 50G \
--left  $WORKDIR/read_QC/fastp/short_1.fastq.gz \
--right $WORKDIR/read_QC/fastp/short_2.fastq.gz \
--CPU 16 \
--output $OUTDIR


