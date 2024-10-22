#!/bin/bash

#SBATCH --partition=spgpu
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --mem-per-gpu=128GB
#SBATCH --account=mihalcea98
#SBATCH --time=00-08:00:00 

# set up job
module load python/3.9.12 cuda
pushd /home/mehars/cultural-trends/shell_scripts
conda activate cultural_trends

# run job
python ../scripts/wvs_query_hf.py \
    --qid 2 \
    --model bigscience/mt0-small \
    --version 1 \
    --lang en \
    --max-tokens 10 \
    --temp 0.7 \
    --batch-size 4 \
    --fewshot 0 \
    --cuda 0 \
    --country us