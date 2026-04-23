#!/bin/bash
#SBATCH --job-name=kraken_db_download
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dsr84@georgetown.edu
#SBATCH --output=/home/dsr84/kraken/kraken2-%j.out
#SBATCH --error=/home/dsr84/kraken/kraken2-%j.err
#SBATCH --time=4:00:00
#SBATCH --mem=16G

cd /home/dsr84/kraken/kraken2_db

echo "Downloading Kraken2 database..."

wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_08_GB_20260226.tar.gz

echo "Unzipping database..."
tar -xvzf k2_standard_20240112.tar.gz
