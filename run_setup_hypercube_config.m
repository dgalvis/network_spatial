%=========================================================================%
% Function: run_setup_hypercube_config
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% Parameters for run_setup_hypercube.m prior to being fed into run_model_hypercube.m
%
% Parameters
% ==========
% model    = 'fn' or 'srk' depending on the model you wish to use
% num_pars = number of networks to run, integer
% Gfracrng = 2x1 array in [0,1] Glucose fraction (0 - high glucose)
% gconnrng = 2x1 array, gap junction conductance 
% poprng   = 2x1 array, population 1 fraction in [0,1]
% itrng    = 2x1 array, number of iterations of swapping algorithm
% gl1meanrng = 2x1 array, mean gkatp of population 1
% gl2meanrng = 2x1 array, mean gkatp of population 2
% gl1stdrng = 2x1 array, std gkatp of population 1
% gl2stdrng = 2x1 array, std gkatp of population 2
% Tmax     = time to run the ode of the network
% seed     = seed for random number generator of hypercube
% radius   = radius of the islet
% name     = folder name for this run
%
% ric_scale= variance of initial conditions IC*(1 + randn/ric_scale)
% method_sort      : local - local sortedness
%                  : global - global sortedness
% method_swap      : local - local swapping
%                  : global - global swapping
% alpha       : [0,1] - 0 - swap pairs random
%                       1 - swap pairs depend on radius
%                       (0,1) - in between   
% direction - assort (true), disassort (false)
% meth_full - full assort (true), node assort (false)
% seed_swap - seed for run_model_hypercube (swapping and IC)
%=========================================================================%

function out = run_setup_hypercube_config(name, seed, seed_swap)

    out.model = 'fn'; % 'fn' or 'srk'
    out.num_pars = 10000;
    out.Gfracrng = [0.15, 0.3450];
    out.gconnrng = [0.02, 0.02];
    
    
    out.poprng   = [0.1, 0.1]; % pop1 frac range
    out.itrng    = [0, 250]; % swapper iteration range
    
    out.gl1meanrng = [2, 2];
    out.gl2meanrng = [1, 1];
    out.gl1stdrng = [0, 0];
    out.gl2stdrng = [0, 0];
    
    out.Tmax = 6000;
    out.seed = seed; % seed for hypercube
    out.seed_swap = seed_swap; % seed for run_hypercube.m
    
    out.direction = true; % forward - assort, backward - disassort
    
    out.ric_scale = 6; % recommend [3, Inf] (yes you can use Inf)
    out.method_sort = 'local'; % global or local sortedness
    out.method_swap = 'global'; % global or local swapping
    
    % heat based method
    out.heat_info.heat_based = false; %active or not? if false, the others heat parameters don't matter
    out.heat_info.heat_count_max = 20;% how many times can I kick out of a local min or max
    out.heat_info.temp = 0.001; % temperature
    out.heat_info.max_iterations = 10000; % total number of iterations including the heat ones
    
    
    out.alpha  = 1; %[0,1] - 0 - swap pairs random
                    %        1 - swap pairs depend on radius
                    %        (0,1) - in between
    
    
    out.radius = 5.55;
    out.name = ['attempt_', name];
    

end
