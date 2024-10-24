module load python3.9-anaconda cuda
pushd /scratch/mihalcea_root/mihalcea0/mehars/cultural-trends/shell_scripts
conda init bash
source ~/.bashrc
conda activate cultural_trends

echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mehars/.conda/envs/cultural_trends/lib
echo $LD_LIBRARY_PATH

python ../scripts/wvs_majority_vote.py