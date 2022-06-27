%=========================================================================%
% Function: run_setup_single_netgen
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
function run_setup_single_netgen(name, seed, seed2)

    addpath('functions');
    
    config = run_setup_single_netgen_config(name, seed, seed2);
    dout = ['results_single_netgen_', config.name];
    mkdir(dout);
    
    rng(config.seed);
    
    conn_check = false;
    while ~conn_check
        if strcmp(config.netgen_method, 'WS')
            net_conns = watts_strogatz(config.num_nodes, config.num_conns / 2, config.rewiring_p);
        elseif strcmp(config.netgen_method, 'BA')
            seed_net = watts_strogatz(config.num_conns + 1, config.num_conns / 2, 0);
            net_conns = barabasi_albert(config.num_nodes, config.num_conns / 2, seed_net);
            config.net_init = seed_net;
        end
        config.net_conns = net_conns;
        
        if max(conncomp(graph(net_conns))) == 1
            conn_check = true;
        end
        
    end
    
    
    % Run swapping algorithm (same for all parameters)   
    [gl_all, pops_all, assort_all] = ...
        swapping_algorithm(config.net_conns, ...
                           [], ...
                           config.pars(1, 3:end), ...
                           config.direction, config.method_sort, config.method_swap, config.heat_info, 0);
    
    
    
    % maybe swapping algorithm in the opposite direction
    if config.both
        [gl_all_b, pops_all_b, assort_all_b] = ...
            swapping_algorithm(config.net_conns, ...
                               [], ...
                               config.pars(1, 3:end), ...
                               ~config.direction, ...
                                config.method_sort, config.method_swap, config.heat_info, 0, pops_all(:,end)); 
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
    % Initialise the network for ode modelling
    if strcmp(config.model, 'srk')
        net = class_srk;
    elseif strcmp(config.model, 'fn')
        net = class_fn;
    end
    net.make_network(config.net_conns);
    random_initial_conditions = (1 + randn(length(net.y0),1)/config.ric_scale);
       
    save(fullfile(dout,'parameters.mat'), 'gl_all', 'pops_all', 'assort_all', 'random_initial_conditions', 'config');
end
