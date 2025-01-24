#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=hifiasm
#SBATCH --output=/data/users/hkamdoumkemfio/assembly_annotation_course/log/output_hifiasm_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/assembly_annotation_course/log/error_hifiasm_%j.e
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=end
#SBATCH --partition=pibu_el8

# Define input and output directories
WORKDIR=/data/courses/assembly-annotation-course/raw_data/Istisu-1
OUTDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/hifiasm

mkdir -p $OUTDIR

# Run hifiasm
apptainer exec \
--bind $WORKDIR,$OUTDIR \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm \
-o $OUTDIR/istisu.asm \
-t16 \
/data/courses/assembly-annotation-course/raw_data/Istisu-1/ERR11437352.fastq.gz

cd $OUTDIR
awk '/^S/{print ">"$2;print $3}' istisu.asm.bp.p_ctg.gfa > istisu.asm.p_ctg.fa

