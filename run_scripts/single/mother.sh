# sbatch run_setup_single.sh $1 1 1 #name and seed and seed2

# how many to run depends on the how many iterations convergence takes in 
# run_setup_single.sh. Can be checked in parameters.mat
sbatch run_model_single.sh 1:20 $1 # mypars and name
sbatch run_model_single.sh 21:40 $1 
sbatch run_model_single.sh 41:60 $1 
sbatch run_model_single.sh 61:80 $1 
sbatch run_model_single.sh 81:100 $1 
sbatch run_model_single.sh 101:120 $1 
sbatch run_model_single.sh 121:140 $1 
sbatch run_model_single.sh 141:160 $1 
sbatch run_model_single.sh 161:180 $1 
sbatch run_model_single.sh 181:200 $1 
sbatch run_model_single.sh 201:220 $1
sbatch run_model_single.sh 221:240 $1 


# Just in case convergence takes more swaps in the seed you use.
#sbatch run_model_single.sh 241:260 $1 
#sbatch run_model_single.sh 261:280 $1 
#sbatch run_model_single.sh 281:300 $1 
#sbatch run_model_single.sh 301:320 $1 
#sbatch run_model_single.sh 321:340 $1 
#sbatch run_model_single.sh 341:360 $1 
#sbatch run_model_single.sh 361:380 $1 
#sbatch run_model_single.sh 381:400 $1 
#sbatch run_model_single.sh 401:420 $1 
#sbatch run_model_single.sh 421:440 $1 
#sbatch run_model_single.sh 441:460 $1 
#sbatch run_model_single.sh 461:480 $1 
#sbatch run_model_single.sh 481:500 $1 


# sbatch run_concat_single.sh $1  #name 
