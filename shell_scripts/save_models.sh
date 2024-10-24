#!/bin/bash

#SBATCH --partition=spgpu
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --mem-per-gpu=128GB
#SBATCH --account=mihalcea98
#SBATCH --time=00-08:00:00 

# set up job
# module load python/3.9.12 cuda
module load python3.9-anaconda cuda
pushd /scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/shell_scripts
conda init bash
source ~/.bashrc
conda activate cultural_trends

# echo "Listing all conda environments..."
# conda info --envs

# echo "transformers version:"
# pip list | grep transformers

# Define arrays for models and their corresponding save names
save_dir='/scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/models2'
# models=('FreedomIntelligence/AceGPT-13B-chat' 'meta-llama/Llama-2-13b-chat-hf' 'bigscience/mt0-xxl')
models=('bigscience/mt0-xxl')
# save_names=('AceGPT-13B-chat' 'Llama-2-13b-chat-hf' 'mt0-xxl')
save_names=('mt0-xxl')

# Loop through each model and corresponding save name
for i in "${!models[@]}"; do
    model="${models[$i]}"
    save_name="${save_names[$i]}"

    echo "Processing model: $model, saving as: $save_name in directory: $save_dir"
    
    # Run the Python script with the current model and save parameters
    python /scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/load_models.py \
        --model_name "$model" \
        --save_name "$save_name" \
        --save_dir "$save_dir"
done