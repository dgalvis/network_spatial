%=========================================================================%
% Function: run_setup_single_netgen_config
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
% 11/05/2022
% code addition for Fitzhugh Nagumo Model
%
% Parameters for run_model_single.m. Runs a single swapping algorithm and
% simulates the model for all the different parameters over all iterations
% of the swapping algorithm.
%
% Parameters
% ==========
% model    = 'fn' or 'srk' depending on the model you wish to use
% Tmax     = time to run the ode of the network
% ric_scale= variance of initial conditions IC*(1 + randn/ric_scale)

% direction= 'true' or 'false' (forward or backward sortedness)
% both     = 'true' or 'false' (if true do direction then ~direction)

% seed     = seed for swapping algorithm
% seed2    = seed for ICs

% name     = folder name for this run
%
% method_sort      : local - local sortedness
%                  : global - global sortedness
% method_swap      : local - local swapping
%                  : global - global swapping
 
%
% num_pars = number of parameters to running over
% inc      = run swap iterations 1:inc:end
%=========================================================================%
function out = run_setup_single_netgen_config(name, seed, seed2)

    out.model = 'fn'; % 'fn' or 'srk'
    out.Tmax = 6000; % max time points
                     % recommended >360000 for srk
                     % recommended >5000 for fn
                   
    out.ric_scale = 6; % recommend [3, Inf] (yes you can use Inf)
    
    out.direction = true; % forward - assort, backward - disassort
    
    % Go direction of out.direction then go the opposite direction
    % so assort then disassort or vice-versa 
    out.both =  false;
    
    out.seed = seed; % seed for swapping algorithm
    out.seed2 = seed2; % seed for random initial conditions
    
    out.name = ['attempt_', name];
    
    out.method_sort = 'local'; % global or local sortedness
    out.method_swap = 'global'; % global or local swapping
    
    % heat based method
    out.heat_info.heat_based = false; %active or not? if false, the others heat parameters don't matter
    out.heat_info.heat_count_max = 20;% how many times can I kick out of a local min or max
    out.heat_info.temp = 0.001; % temperature
    out.heat_info.max_iterations = 10000; % total number of iterations including the heat ones
    
    out.netgen_method = 'WS'; % 'WS' - watts_strogatz
                              % 'BA' - barabasi_albert
                              
    out.num_nodes = 1000; % number of nodes for general network
    out.num_conns = 12; % average degree of general network
    out.rewiring_p = 0.2; % for 'WS' only, ignored for 'BA'

    out.num_pars = 20;
    out.pars = zeros(out.num_pars, 8);
    
    % Can be different values in each entry
    out.pars(:,1) = linspace(0.15, 0.345, out.num_pars); % G (global drive)
                                                    % 0.3, 0.55 srk
                                                    % 0.15, 0.345 fn
    
    
    out.pars(:,2) = 0.1; % gconn (connectivity)
                          % 1, 2, 10 srk
                          % 0.01, 0.02, 0.1 fn
    
    % Always the same value!
    out.pars(:,3) = 0.1; % population 1 fraction
    out.pars(:,4) = 1000; % max swapping iterations
    out.pars(:,5) = 2; % gl1mean (gl pop1) 60 - srk, 2 - fn
    out.pars(:,6) = 1; % gl2mean (glpop2) 100 - srk, 1 -fn
    out.pars(:,7) = 0; %gl1std
    out.pars(:,8) = 0; %gl2std 
    
    out.inc = 1; % do 1:??:end iterations of swapping algorithm

end