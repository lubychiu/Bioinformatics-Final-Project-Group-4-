#!/bin/bash
#SBATCH --job-name=remove_human_reads
#SBATCH --output=/home/dsr84/bowtie_out/bowtie-%j.out
#SBATCH --error=/home/dsr84/bowtie_out/bowtie-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dsr84@georgetown.edu
#SBATCH --time=8:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# ---------SET UP----------
SAMPLE="SAMPLE_NAME"
HUMAN_INDEX="PATH/TO/INDEX"   # <-- change to human genome index
READ1="/PATH/TO/READ"
READ2="/PATH/TO/READ"
OUTPUTDIR="/PATH/TO/OUTPUT"

# --------- LOAD MODULES ----------
module purge
module load bowtie2/2.5.4
module load samtools

# --------- SETUP OUTPUT ----------
mkdir -p "${OUTPUTDIR}"
cd "${OUTPUTDIR}"

echo "Removing human reads from ${SAMPLE}"

# --------- ALIGN AND EXTRACT NON-HUMAN READS ----------
bowtie2 -p 8 -x "${HUMAN_INDEX}" \
  -1 "${READ1}" -2 "${READ2}" \
  --very-sensitive \
  --un-conc-gz "${SAMPLE}_nonhuman_R%.fq.gz" \
  -S /dev/null

echo "Finished removing human reads"

# Output files:
# ${SAMPLE}_nonhuman_R1.fq.gz
# ${SAMPLE}_nonhuman_R2.fq.gz
