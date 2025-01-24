#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_merqury%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_merqury%j.e
#SBATCH --partition=pibu_el8

# Input file
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/Istisu-1/ERR11437352.fastq.gz
FLYE_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/hifiasm/istisu.asm.p_ctg.fa
LJA_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/lja/assembly.fasta


# Define  output directories

OUTPUT=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly_qc/Merqury_Output
FLYE_MERQURY_OUT="$OUTPUT/Flye"
HIFIASM_MERQURY_OUT="$OUTPUT/Hifiasm"
LJA_MERQURY_OUT="$OUTPUT/LJA"

MERYL=$OUTPUT/Meryl
mkdir -p $OUTPUT
mkdir -p $MERYL
cd $OUTPUT

export MERQURY="/usr/local/share/merqury"

#check for best kmer
#apptainer exec --bind $OUTPUT_REPO/ /containers/apptainer/merqury_1.3.sif \
#$MERQURY/best_k.sh 100000000

K_MER=19

#creating kmer dbs
apptainer exec --bind $OUTPUT/ /containers/apptainer/merqury_1.3.sif \
 meryl k=$K_MER count $WORKDIR output $MERYL


# Run Merqury for flye assembly
mkdir -p $FLYE_MERQURY_OUT
cd $FLYE_MERQURY_OUT
apptainer exec --bind $OUTPUT/ /containers/apptainer/merqury_1.3.sif \
merqury.sh $MERYL $FLYE_MERQURY_OUT Flye_Merqury_Out


# Run Merqury for hifiasm assembly 
mkdir -p $HIFIASM_MERQURY_OUT
cd $HIFIASM_MERQURY_OUT
apptainer exec --bind $OUTPUT/ /containers/apptainer/merqury_1.3.sif \
merqury.sh $MERYL $HIFIASM_MERQURY_OUT Hifiasm_Merqury_Out


# Run Merqury for LJA assembly
mkdir -p $LJA_MERQURY_OUT
cd $LJA_MERQURY_OUT
apptainer exec --bind $OUTPUT/ /containers/apptainer/merqury_1.3.sif \
merqury.sh $MERYL $LJA_MERQURY_OUT LJA_Merqury_Out