#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="kmer_counting"
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_slurm_03_kmer%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_slurm_03_kmer%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/Istisu-1/ERR11437352.fastq.gz
OUTPUT=/data/users/hkamdoumkemfio/assembly_annotation_course/kmer_counting

mkdir -p $OUTPUT

# Add the modules

module load Jellyfish/2.3.0-GCC-10.3.0

# Run jellyfish

jellyfish count -C -m 21 -s 5G -t 4 <(zcat "$WORKDIR") -o "$OUTPUT/reads.jf"

jellyfish histo -t 4 "$OUTPUT/reads.jf" > "$OUTPUT/reads.histo"
