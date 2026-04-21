#!/bin/bash
#SBATCH --job-name=kraken_db_download
#SBATCH --output=/home/yc1201/final_project/kraken2-%j.out
#SBATCH --error=/home/yc1201/final_project/kraken2-%j.err
#SBATCH --time=4:00:00
#SBATCH --mem=16G

cd /home/yc1201/final_project

echo "Downloading Kraken2 database..."

wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20240112.tar.gz

echo "Unzipping database..."
tar -xvzf k2_standard_20240112.tar.gz
