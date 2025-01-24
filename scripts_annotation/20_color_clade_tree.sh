#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=10G
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="color clade"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_color%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_color%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
LOCAL_REPO=/data/users/hkamdoumkemfio/transcriptome_assembly/scripts
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/color_clade
COPIA_TSV=/data/users/hkamdoumkemfio/transcriptome_assembly/output/seqKit/Copia_sequences.fa.rexdb-plant.cls.tsv
GYPSY_TSV=/data/users/hkamdoumkemfio/transcriptome_assembly/output/seqKit/Gypsy_sequences.fa.rexdb-plant.cls.tsv
mkdir -p $OUTPUT
cd $OUTPUT
#create a table with a unique color code for each Clade
#### Copia
declare -A color_map=(
    ["Ale"]="#FF0000"
    ["Tork"]="#696D5E"
    ["SIRE"]="#484394"
    ["Ivana"]="#FFC001"
    ["Bianca"]="#0040FF"
    ["Angela"]="#00FFFF"
    ["Athila"]="#FFA500"
)

for clade in "${!color_map[@]}"; do
    #Filtre les lignes pour le clade actuel, extrait l'ID TE, et formate la sortie
    grep -e $clade $COPIA_TSV | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed "s/$/ ${color_map[$clade]} $clade/" > "${clade}_ID_Copia.txt"
done

###GYPSY
declare -A color_map=(
    ["Retand"]="#FF0000"
    ["Reina"]="#696D5E"
    ["Tekay"]="#484394"
    ["CRM"]="#FFC001"
    ["Athila"]="#FFA500"
)

for clade in "${!color_map[@]}"; do
    #Filtre les lignes pour le clade actuel, extrait l'ID TE, et formate la sortie
    grep -e $clade $GYPSY_TSV | cut -f 1 | sed 's/:/_/' | sed 's/#.*//' | sed "s/$/ ${color_map[$clade]} $clade/" > "${clade}_ID_Gypsy.txt"
done

#### >>>>cat ../output/color_clade/* >> dataset_color_strip_template.txt 
#### >>>>grep "INT" /data/users/rzahri/annotation_course/output/EDTA_annotation/assembly.fasta.mod.EDTA.TEanno.sum | awk '{print $1","$2}' >> dataset_color_strip_template.txt 
