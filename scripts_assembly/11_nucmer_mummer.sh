#!/usr/bin/env bash

#SBATCH --time=05:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=nucmer_mummer
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_nucmer_mummer%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_nucmer_mummer%j.e
#SBATCH --partition=pibu_el8


# Input file 
FLYE_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/hifiasm/istisu.asm.p_ctg.fa
LJA_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/lja/assembly.fasta
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa


# Define output directories
OUTPUT=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly_qc/Nucmer_Mummer_Output
mkdir -p $OUTPUT/Nucmer_Output
mkdir -p $OUTPUT/Mummer_Output

# Run Nucmer for Flye assembly
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix $OUTPUT/Nucmer_Output/Flye_nucmer --breaklen 1000 --mincluster 1000 --threads 8 $REF $FLYE_ASSEMBLY

# Run Nucmer for Hifiasm assembly
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix $OUTPUT/Nucmer_Output/Hifiasm_nucmer --breaklen 1000 --mincluster 1000 --threads 8 $REF $HIFIASM_ASSEMBLY

# Run Nucmer for LJA assembly
echo "Running Nucmer for LJA Assembly..."
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    nucmer --prefix $OUTPUT/Nucmer_Output/LJA_nucmer --breaklen 1000 --mincluster 1000 --threads 8 $REF $LJA_ASSEMBLY

# Run MummerPlot for Flye assembly
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R $REF -Q $FLYE_ASSEMBLY --breaklen 1000 --filter -t png --large --layout --fat \
    -p $OUTPUT/Mummer_Output/Mummer_Flye $OUTPUT/Nucmer_Output/Flye_nucmer.delta

# Run MummerPlot for Hifiasm assembly
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R $REF -Q $HIFIASM_ASSEMBLY --breaklen 1000 --filter -t png --large --layout --fat \
    -p $OUTPUT/Mummer_Output/Mummer_Hifiasm $OUTPUT/Nucmer_Output/Hifiasm_nucmer.delta

# Run MummerPlot for LJA assembly
apptainer exec --bind /data:/data /containers/apptainer/mummer4_gnuplot.sif \
    mummerplot -R $REF -Q $LJA_ASSEMBLY --breaklen 1000 --filter -t png --large --layout --fat \
    -p $OUTPUT/Mummer_Output/Mummer_LJA $OUTPUT/Nucmer_Output/LJA_nucmer.delta
