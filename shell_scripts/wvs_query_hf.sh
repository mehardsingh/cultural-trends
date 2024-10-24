#!/bin/bash

#SBATCH --partition=spgpu
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --mem-per-gpu=128GB
#SBATCH --account=mihalcea98
#SBATCH --time=00-08:00:00 

# set up job
# module load python/3.9.12 cuda
# pushd /scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/shell_scripts
# conda init bash
# source ~/.bashrc
# conda activate cultural_trends
module load python3.9-anaconda cuda
pushd /scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/shell_scripts
conda init bash
source ~/.bashrc
conda activate cultural_trends

# run job
# python ../scripts/wvs_query_hf.py \
#     --qid 2 \
#     --model bigscience/mt0-small \
#     --version 1 \
#     --lang en \
#     --max-tokens 10 \
#     --temp 0.7 \
#     --batch-size 4 \
#     --fewshot 0 \
#     --cuda 0 \
#     --country us

models=('FreedomIntelligence/AceGPT-13B-chat' 'meta-llama/Llama-2-13b-chat-hf' 'bigscience/mt0-xxl')
countries=('egypt' 'us')
languages=('ar' 'en')

for model in "${models[@]}"; do
    for country in "${countries[@]}"; do
        for lang in "${languages[@]}"; do
            python ../scripts/wvs_query_hf.py \
                --qid -1 \
                --model "$model" \
                --version 1 \
                --lang "$lang" \
                --max-tokens 50 \
                --temp 0.7 \
                --batch-size 4 \
                --fewshot 0 \
                --cuda 0 \
                --country "$country"
        done
    done
done