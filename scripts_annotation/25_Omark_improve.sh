#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=4:00:00
#SBATCH --mail-user=hansoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="Omark_improve"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_omark_improve%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_omark_improve%j.e
#SBATCH --partition=pibu_el8

#Define input and output directories
LOCAL_REPO=/data/users/hkamdoumkemfio/transcriptome_assembly/scripts
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Omark_Prep/ormark
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
OMER=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.omamer

protein=/data/users/hkamdoumkemfio/transcriptome_assembly/output/extract_mRNA/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=/data/users/hkamdoumkemfio/transcriptome_assembly/output/AED/filtered.genes.renamed.gff3
BLAST=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Blast/maker_proteins_blastp_output
OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"
ISOFORMS=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Omark_Prep/isoforms.txt
PYTHON_SCRIPT=/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/utils/omark_contextualize.py

mkdir -p $OUTPUT
cd $OUTPUT

# Initialize conda environment (this step ensures conda works correctly)
source /home/hkamdoumkemfio/miniconda3/etc/profile.d/conda.sh  # Adjust the path if necessary, e.g., '/opt/conda/etc/profile.d/conda.sh'
conda init bash

# Download the Orthologs of fragmented and missing genes from OMArk database
# Ensure necessary Python packages are available in the conda environment
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/
pip install omadb pandas tqdm biopython gffutils pyfaidx

# Running the omark_contextualize.py script for fragment and missing HOGs
$PYTHON_SCRIPT fragment -m $OMER -o $OUTPUT -f fragment_HOGs
$PYTHON_SCRIPT missing -m $OMER -o $OUTPUT -f missing_HOGs

OMARK_FOLDER="$OUTPUT" 

python - <<EOF
import glob
import pandas as pd
from omadb import Client
import omadb.OMARestAPI
from tqdm import tqdm
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO
from io import StringIO
import gffutils
from pyfaidx import Fasta
import argparse

# Télécharger les Orthologues des gènes fragmentés et manquants
client = Client()

# Récupérer les orthologues des gènes fragmentés et manquants
orthologs_fragmented = client.getOrthologs('fragmented')  # Remplacer par la méthode exacte
orthologs_missing = client.getOrthologs('missing')  # Remplacer par la méthode exacte

# Sauvegarder les orthologues dans des fichiers CSV
orthologs_fragmented.to_csv("$OUTPUT/fragmented_orthologs.csv")
orthologs_missing.to_csv("$OUTPUT/missing_orthologs.csv")

EOF
# Switching to miniprot conda environment
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/miniprot_conda

FLYE_ASSEMBLY=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
MISSING_HOG=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Omark_Prep/ormark/missing_HOGs.fa
OUTPUT_REPO=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Miniprot

mkdir -p $OUTPUT_REPO
cd $OUTPUT_REPO
touch $OUTPUT_REPO/missing.gff
