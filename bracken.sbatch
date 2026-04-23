#!/bin/bash
#SBATCH --job-name=bracken_run
#SBATCH --output=/home/yc1201/final_project/bracken/bracken-%j.out
#SBATCH --error=/home/yc1201/final_project/bracken/bracken-%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=yc1201@georgetown.edu
#SBATCH --time=01:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4

set -euo pipefail

# --------- PATHS ----------
DB="/home/yc1201/final_project/kraken2"
KRAKEN_DIR="/home/yc1201/final_project/kraken2"
OUTDIR="/home/yc1201/final_project/bracken"

mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

# --------- CONDA ----------
# avoid conda activation script crashes
export QT_XCB_GL_INTEGRATION=""
eval "$(conda shell.bash hook)"
conda activate kraken_env

echo "Starting Bracken"

# --------- PARAMETERS ----------
READ_LEN=150   # change if your reads are not 150bp
LEVEL="S"      # S = species, G = genus, F = family

# --------- SAMPLE 1 ----------
echo "Running S13_350"

bracken \
  -d "${DB}" \
  -i "${KRAKEN_DIR}/S13_350.report" \
  -o S13_350.bracken \
  -r ${READ_LEN} \
  -l ${LEVEL}

# --------- SAMPLE 2 ----------
echo "Running S9_350_1"

bracken \
  -d "${DB}" \
  -i "${KRAKEN_DIR}/S9_350_1.report" \
  -o S9_350_1.bracken \
  -r ${READ_LEN} \
  -l ${LEVEL}

echo "Bracken completed"
