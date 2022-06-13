%=========================================================================%
% Function: run_model_netgen
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% This code runs the swapping algorithm to distribute population 1 and 2
% throughout the general network then runs the ode and saves the result. Uses
% run_setup_netgen_config(). It will run a subset of the derived hypercube
% parameters (see the config file).
%
% Note: run_setup_netgen.m must be run first!!!
%
% Parameters
% ==========
% mypars : To distribute the full set of parameters, this array contains a
% subset to run
% name   : the name given to run_setup_hypercube when setting up the run
% keep_traj: if true, then keep the trajectory (which makes huge files and
% is false by default)
%=========================================================================%
function run_model_netgen(mypars, name, keep_traj)

    addpath('functions');
    
    if nargin < 3
        keep_traj = false;
    end
    
    % Load in the ranges
    config = run_setup_netgen_config(name, 0, 0, 0);
    dout = ['results_netgen_', config.name];
    clear config;
    
    load(fullfile(dout, 'cube.mat'), 'config');
    
    rng(config.seed_swap);
    seeds = randi(2^32 - 1, [config.num_pars, 1]);

    for i = mypars
        disp(['par set: ', num2str(i), ' ']);tic;
        rng(seeds(i));
        
        % Initialise the network for ode modelling
        if strcmp(config.model, 'srk')
            net = class_srk;
        elseif strcmp(config.model, 'fn')
            net = class_fn;
        end
           
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

        net.make_network(config.net_conns * config.pars(i, 2));
        
        
        [gl_all, pops_all, assort_all] = ...
            swapping_algorithm(config.net_conns, ...
                               [], ...
                               config.pars(i, 3:end), ...
                               config.direction, config.method_sort, config.method_swap, config.heat_info, 0);
                           
        swap_its = length(assort_all);
        
        % Set gkatp (gl) based on the swapping algorithm to the populations
        assort = assort_all(end);
        net.gl = gl_all(:,end);
        pops = pops_all(:,end);
        
        % Set initial conditions
        random_initial_conditions = (1 + randn(length(net.y0),1)/config.ric_scale);
        net.y0 = net.y0  .* random_initial_conditions;
        
        
        net.G = config.pars(i,1);
        net.run_ode(config.Tmax);
        net.run_stats(double(pops));
        if ~keep_traj
            net.y = [];
            net.t = [];
        end
        
        % Keep some info
        gl = net.gl;
        gconns = net.gconns;
        pvals = config.pars(i,:);
        
        % Save
        save(fullfile(dout, ['out_', num2str(i), '.mat']), 'net', 'pops', ...
                             'gl', 'gconns', 'pvals', 'assort', 'swap_its', '-v7.3');
        disp(toc);
    end
end
