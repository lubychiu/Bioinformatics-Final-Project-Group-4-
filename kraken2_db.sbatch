#!/bin/bash
#SBATCH --job-name=kraken2_db_build
#SBATCH --output=/home/dsr84/junk/%x.o%j
#SBATCH --error=/home/dsr84/junk/%x.e%j
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dsr84@georgetown.edu
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G

# Load conda (important on many clusters)

source ~/.bashrc

# Activate your environment

conda activate kraken_env

# Move to a directory with enough space (VERY important)

cd /home/dsr84/kraken/kraken2_db

# Build the standard Kraken2 database

kraken2-build --standard 
--threads 16 
--db kraken_db
