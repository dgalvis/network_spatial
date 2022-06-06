%=========================================================================%
% Function: run_model_single_config
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

% radius   = radius of the islet
% name     = folder name for this run
%
% method      : local - local sortedness
%               global - global sortedness
% alpha       : [0,1] - 0 - swap pairs random
%                       1 - swap pairs depend on radius
%                       (0,1) - in between   
%
% num_pars = number of parameters to running over
% inc      = run swap iterations 1:inc:end
%=========================================================================%
function out = run_setup_single_config(name, seed, seed2)

    out.model = 'srk'; % 'fn' or 'srk'
    out.Tmax = 360000; % max time points
                     % recommended >360000 for srk
                     % recommended >5000 for fn
                   
    out.ric_scale = 6; % recommend [3, Inf] (yes you can use Inf)
    
    out.direction = true; % forward - assort, backward - disassort
    
    % Go direction of out.direction then go the opposite direction
    % so assort then disassort or vice-versa 
    out.both =  false;
    
    out.seed = seed; % seed for swapping algorithm
    out.seed2 = seed2; % seed for random initial conditions
    
    out.radius = 5.55;
    out.name = ['attempt_', name];
    
    out.method = 'global'; % global or local sortedness
    out.alpha  = 1; %[0,1] - 0 - swap pairs random
                    %        1 - swap pairs depend on radius
                    %        (0,1) - in between

    out.num_pars = 20;
    out.pars = zeros(out.num_pars, 8);
    
    % Can be different values in each entry
    out.pars(:,1) = linspace(0.3, 0.7, out.num_pars); % G (global drive)
                                                    % 0.3, 0.55 srk
                                                    % 0, 0.4 fn
    
    
    out.pars(:,2) = 1; % gconn (connectivity)
                          % 1, 2, 10 srk
                          % 0.01, 0.05, 0.1 fn
    
    % Always the same value!
    out.pars(:,3) = 0.1; % population 1 fraction
    out.pars(:,4) = 1000; % max swapping iterations
    out.pars(:,5) = 60; % gl1mean (gl pop1) 60 - srk, 2 - fn
    out.pars(:,6) = 100; % gl2mean (glpop2) 100 - srk, 1 -fn
    out.pars(:,7) = 0; %gl1std
    out.pars(:,8) = 0; %gl2std 
    
    out.inc = 1; % do 1:??:end iterations of swapping algorithm

end
