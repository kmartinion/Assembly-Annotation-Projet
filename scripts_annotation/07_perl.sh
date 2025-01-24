#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name=perl
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__perl%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log//output__perl%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out
WORKDIR=/data/users/rchoudhury/assembly-annotation-course/scripts/04-parseRM.pl

# Load the BioPerl module (required for the Perl script)
module add BioPerl/1.7.8-GCCcore-10.3.0

# Run the Perl script with the required parameters
perl $ -i $WORKDIR -l 50,1 -v
