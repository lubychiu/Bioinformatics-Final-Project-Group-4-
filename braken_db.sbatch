#!/bin/bash
#SBATCH --job-name=bracken_build
#SBATCH --output=/home/dsr84/bracken/bracken-build-%j.out
#SBATCH --error=/home/dsr84/bracken/bracken-build-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=dsr84@georgetown.edu
#SBATCH --time=12:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=16

source ~/.bashrc
conda activate kraken_env

bracken-build \
  -d /home/dsr84/kraken/kraken2_db \
  -t 16 \
  -k 35 \
  -l 150
