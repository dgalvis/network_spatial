#!/bin/bash            
#SBATCH --time=200:00:00     # Walltime            
#SBATCH --mem=32G  # memory/cpu            
#SBATCH --ntasks 16            
#SBATCH --nodes 1-1            
#SBATCH --job-name=run_net
#SBATCH --output=run_net.out            
#SBATCH --error=run_net.err            
#SBATCH --account=galvisd-virtual-grid-project            
#SBATCH --qos=castles            
            
module purge; module load bluebear # this line is required            
module load MATLAB/2019b            
            
BB_WORKDIR=$(mktemp -d /scratch/${USER}_${SLURM_JOBID}.XXXXXX)            
export TMPDIR=${BB_WORKDIR}  
         
cd ../..      
matlab -nodisplay -r "run_model_hypercube($1, '$2');exit;" 
