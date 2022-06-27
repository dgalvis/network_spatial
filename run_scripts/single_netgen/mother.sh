# sbatch run_setup_single_netgen.sh $1 1 1 #name and seed and seed2

# how many to run depends on the how many iterations convergence takes in 
# run_setup_single.sh. Can be checked in parameters.mat
sbatch run_model_single_netgen.sh 1:20 $1 # mypars and name
sbatch run_model_single_netgen.sh 21:40 $1 
sbatch run_model_single_netgen.sh 41:60 $1 
sbatch run_model_single_netgen.sh 61:80 $1 
sbatch run_model_single_netgen.sh 81:100 $1 
sbatch run_model_single_netgen.sh 101:120 $1 
sbatch run_model_single_netgen.sh 121:140 $1 
sbatch run_model_single_netgen.sh 141:160 $1 
sbatch run_model_single_netgen.sh 161:180 $1 
sbatch run_model_single_netgen.sh 181:200 $1 
sbatch run_model_single_netgen.sh 201:220 $1
sbatch run_model_single_netgen.sh 221:240 $1 


# Just in case convergence takes more swaps in the seed you use.
sbatch run_model_single_netgen.sh 241:260 $1 
sbatch run_model_single_netgen.sh 261:280 $1 
sbatch run_model_single_netgen.sh 281:300 $1 
sbatch run_model_single_netgen.sh 301:320 $1 
#sbatch run_model_single_netgen.sh 321:340 $1 
#sbatch run_model_single_netgen.sh 341:360 $1 
#sbatch run_model_single_netgen.sh 361:380 $1 
#sbatch run_model_single_netgen.sh 381:400 $1 
#sbatch run_model_single_netgen.sh 401:420 $1 
#sbatch run_model_single_netgen.sh 421:440 $1 
#sbatch run_model_single_netgen.sh 441:460 $1 
#sbatch run_model_single_netgen.sh 461:480 $1 
#sbatch run_model_single_netgen.sh 481:500 $1 


# sbatch run_concat_single_netgen.sh $1  #name 
