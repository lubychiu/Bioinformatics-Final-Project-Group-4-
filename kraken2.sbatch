#!/bin/bash
#SBATCH --job-name=kraken2_run
#SBATCH --mail-type=START,END,FAIL
#SBATCH --mail-user=dsr84@georgetown.edu
#SBATCH --output=/home/dsr84/kraken/kraken2-run-%j.out
#SBATCH --error=/home/dsr84/kraken/kraken2-run-%j.err
#SBATCH --time=08:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G

# Load conda

source ~/.bashrc

# Activate your Kraken2 environment

conda activate kraken_env

# Go to working directory

cd /home/dsr84/kraken/kraken1_out

echo "Running Kraken2 classification..."

kraken2 \
  --db /home/dsr84/kraken/kraken2_db \
  --threads 16 \
  --report CNR0930221.report \
  --output CNR0930221.kraken \
  --paired \
  --gzip-compressed \
  /home/dsr84/bowtie/dehosted_reads/CNR0930221_nonhuman_R1.fq.gz /home/dsr84/bowtie/dehosted_reads/CNR0930221_nonhuman_R2.fq.gz

echo "Kraken2 run complete."
