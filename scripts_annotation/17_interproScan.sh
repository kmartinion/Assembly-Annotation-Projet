#!/usr/bin/env bash

#SBATCH --time=20:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=10
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name="InterproScan"
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_interproscan%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output_interproscan%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/InterproScan
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
PROTEIN_RENAME="$LOCAL_REPO/assembly.all.maker.proteins.fasta.renamed.fasta"
GFF_RENAME="$LOCAL_REPO/assembly.all.maker.noseq.gff.renamed.gff"

mkdir -p $OUTPUT
cd $OUTPUT


# Run InterProScan in a apptainer container
apptainer exec \
    --bind $WORKDIR:/data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename \
    --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data \
    --bind $OUTPUT \
    --bind $COURSEDIR \
    --bind ${SCRATCH:-/tmp}:/temp \
    $COURSEDIR/containers/interproscan_latest.sif \
    /opt/interproscan/interproscan.sh \
    -appl pfam \
    --disable-precalc \
    -f TSV \
    --goterms \
    --iprlookup \
    --seqtype p \
    -i /data/users/hkamdoumkemfio/transcriptome_assembly/output/Rename/assembly.all.maker.proteins.fasta.renamed.fasta \
    -o output.iprscan

# Update the GFF3 file with InterProScan results
gff_output="${OUTPUT}/$(basename $GFF_RENAME .gff).iprscan.gff"
$MAKERBIN/ipr_update_gff $GFF_RENAME output.iprscan > "$gff_output"


