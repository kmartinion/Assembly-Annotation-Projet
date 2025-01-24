#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="omark_prep"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_omark_prep%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_omark_prep%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Omark_Prep
protein=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
ISOFORMS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Omark_Prep/isoforms.txt
mkdir -p $OUTPUT
cd $OUTPUT 

# Initialisation de conda
source ~/miniconda3/etc/profile.d/conda.sh 
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/

# Préparation de l'entrée pour Omark
awk '{
    split($1, arr, "-");
    prefix = arr[1];
    isoforms[prefix] = (isoforms[prefix] ? isoforms[prefix] ";" $1 : $1);
} END {
    for (p in isoforms) {
        print isoforms[p];
    }
}' "/data/users/hkamdoumkemfio/transcriptome_assembly/output/Samtools_For_Busco/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.fai" > "$ISOFORMS"

wget https://omabrowser.org/All/LUCA.h5  -P $OUTPUT

# Exécution de la commande `omamer`
omamer search --db LUCA.h5 --query ${protein} --out ${protein}.omamer 

# Exécution de la commande `omark`
omark -f ${protein}.omamer -of ${protein} -i $ISOFORMS -d LUCA.h5 -o $OUTPUT
