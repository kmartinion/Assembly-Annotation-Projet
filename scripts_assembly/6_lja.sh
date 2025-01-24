#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=lja
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_lja_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_lja_%j.e
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8

# Define input and output directories

WORKDIR=/data/courses/assembly-annotation-course/raw_data/Istisu-1
OUTDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/lja

mkdir -p $OUTDIR

# Run lja

apptainer exec \
--bind $WORKDIR,$OUTDIR \
/containers/apptainer/lja-0.2.sif \
lja \
-o $OUTDIR \
--reads /data/courses/assembly-annotation-course/raw_data/Istisu-1/ERR11437352.fastq.gz \
--diploid
