#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=flye
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_flye_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_flye_%j.e
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/courses/assembly-annotation-course/raw_data/Istisu-1
OUTDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye

mkdir -p $OUTDIR

# Run flye 
apptainer exec \
  --bind $WORKDIR,$OUTDIR \
  /containers/apptainer/flye_2.9.5.sif \
  flye \
  --pacbio-hifi /data/courses/assembly-annotation-course/raw_data/Istisu-1/ERR11437352.fastq.gz \
  --out-dir $OUTDIR \
  --threads 16 \
  --genome-size 134m

