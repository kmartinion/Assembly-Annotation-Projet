#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=40
#SBATCH --job-name=quast
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_quast%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_quast%j.e
#SBATCH --partition=pibu_el8


#define variable
OUTPUT=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly_qc/Quast_Output
FLYE_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/hifiasm/istisu.asm.p_ctg.fa
LJA_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/lja/assembly.fasta
REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
QUAST_REF_OUT=$OUTPUT/quast_reference
QUAST_NOREF_OUT=$OUTPUT/quast_no_reference

ls -lh $REF
ls -lh $FLYE_ASSEMBLY

# Define  output directories
mkdir -p $OUTPUT $QUAST_REF_OUT $QUAST_NOREF_OUT

# Run QUAST with reference
apptainer exec --bind /data/courses:/data/courses --bind /data/users:/data/users \
/containers/apptainer/quast_5.2.0.sif quast.py \
-o $QUAST_REF_OUT -r $REF --features $REF_FEATURE --threads 40 \
--eukaryote $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
--labels Quast_Ref_Flye,Quast_Ref_Hifiasm,Quast_Ref_LJA

# Run QUAST without reference
apptainer exec --bind /data/courses:/data/courses --bind /data/users:/data/users \
/containers/apptainer/quast_5.2.0.sif quast.py \
-o $QUAST_NOREF_OUT --threads 40 --eukaryote --est-ref-size 134403675 \
$FLYE_ASSEMBLY $HIFIASM_ASSEMBLY $LJA_ASSEMBLY \
--labels Quast_NoRef_Flye,Quast_NoRef_Hifiasm,Quast_NoRef_LJA