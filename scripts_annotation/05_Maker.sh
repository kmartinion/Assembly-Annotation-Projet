#!/usr/bin/env bash
#SBATCH --ntasks-per-node=50
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --time=4-00:00:00
#SBATCH --mail-user=hansdoum@gmail.com
#SBATCH --mail-type=fail,end
#SBATCH --job-name=MAKER
#SBATCH --output=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__MAKER%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/transcriptome_assembly/output/log/output__MAKER%j.e
#SBATCH --partition=pibu_el8

# Define input and output directories
OUTPUT=/data/users/hkamdoumkemfio/transcriptome_assembly/output/MAKER
WORKDIR=/data/users/hkamdoumkemfio/assembly_annotation_course/assembly/flye/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $OUTPUT
cd $OUTPUT

# Commands for MAKER initialization
# Uncomment this line to generate MAKER control files
#apptainer exec --bind $OUTPUT /data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif maker -CTL

# Define additional directories and tools for MAKER
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
REPEATMASKER_DIR=/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker
export PATH=$PATH:"/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"

# Load necessary modules
module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

# Run MAKER with MPI (Message Passing Interface) for parallel processing
mpiexec --oversubscribe -n 50 \
    apptainer exec \
    --bind $SCRATCH:/TMP \
    --bind /data \
    --bind $AUGUSTUS_CONFIG_PATH \
    --bind $REPEATMASKER_DIR \
     /data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif \
      maker -mpi \
      --ignore_nfs_tmp \
      -TMP /TMP \
      maker_opts.ctl  \
      maker_bopts.ctl \
      maker_evm.ctl \
      maker_exe.ctl

