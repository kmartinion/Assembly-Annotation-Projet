#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=18G
#SBATCH --cpus-per-task=40
#SBATCH --job-name=busco
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_busco%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_busco%j.e
#SBATCH --partition=pibu_el8



#Results of Assembly
FLYE_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
HIFIASM_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/hifiasm/istisu.asm.p_ctg.fa
LJA_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/lja/assembly.fasta
TRINITY_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/trinity.Trinity.fasta

# Define  output directories
OUTPUT=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly_qc/Busco_Output
mkdir -p $OUTPUT
cd $OUTPUT

# Add the modules
module load BUSCO/5.4.2-foss-2021a

#Flye
mkdir -p $OUTPUT/Busco_Flye
cd $OUTPUT/Busco_Flye
busco -i $FLYE_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_Flye_Out -c 40

#Hifiasm
mkdir -p $OUTPUT/Busco_Hifiasm
cd $OUTPUT/Busco_Hifiasm
busco -i $HIFIASM_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_Hifiasm_Out -c 40

#LJA
mkdir -p $OUTPUT/Busco_LJA
cd $OUTPUT/Busco_LJA
busco -i $LJA_ASSEMBLY -m genome -l brassicales_odb10 -o Busco_LJA_Out -c 40

#Trinity for  transcriptome
mkdir -p $OUTPUT/Busco_Trinity
cd $OUTPUT/Busco_Trinity
busco -i $TRINITY_ASSEMBLY -m transcriptome -l brassicales_odb10 -o Busco_Trinity_Out -c 40