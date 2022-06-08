%=========================================================================%
% Function: run_setup_single
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
% 11/05/2022
% code addition for Fitzhugh Nagumo Model
%
% This code runs the swapping algorithm to distribute population 1 and 2
% throughout the islet. This needs to be run befor run_model_single.m
%
% Parameters
% ==========
% name : directory name
% seed : random number generator seed for sorting algorithm
% seed2: random number generator seed for ICs
%=========================================================================%
function run_setup_single(name, seed, seed2)

    addpath('functions');
    
    config = run_setup_single_config(name, seed, seed2);
    dout = ['results_single_', config.name];
    mkdir(dout);
    
    rng(config.seed);
    
    % Run swapping algorithm (same for all parameters)
    net = class_network;
    net.radius = config.radius;
    net.initialise(config.model);    
    [gl_all, pops_all, assort_all] = ...
        swapping_algorithm(net.conns, ...
                           net.index(:,2:end), ...
                           config.pars(1, 3:end), ...
                           config.direction, config.method_sort, config.method_swap, config.alpha);
    
    
    
    % maybe swapping algorithm in the opposite direction
    if config.both
        [gl_all_b, pops_all_b, assort_all_b] = ...
            swapping_algorithm(net.conns, ...
                               net.index(:,2:end), ...
                               config.pars(1, 3:end), ...
                               ~config.direction, ...
                                config.method_sort, config.method_swap, config.alpha, pops_all(:,end)); 
    else
        gl_all_b = [];
        pops_all_b = [];
        assort_all_b = [];
    end
                    
    % add to cell array
    gl_all = [gl_all, gl_all_b];
    pops_all =  [pops_all, pops_all_b];    
    assort_all =  [assort_all, assort_all_b];  
    
    % Identify initial conditions for ode (same for all parameters)
    rng(config.seed2);
    random_initial_conditions = (1 + randn(length(net.sys.y0),1)/config.ric_scale);
       
    save(fullfile(dout,'parameters.mat'), 'gl_all', 'pops_all', 'assort_all', 'random_initial_conditions', 'config');
end
