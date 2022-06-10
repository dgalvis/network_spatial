%=========================================================================%
% Function: run_model_hypercube
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% This code runs the swapping algorithm to distribute population 1 and 2
% throughout the islet then runs the ode and saves the result. Uses
% run_hypercube_config(). It will run a subset of the derived hypercube
% parameters (see the config file).
%
% Note: run_setup_hypercube.m must be run first!!!
%
% Parameters
% ==========
% mypars : To distribute the full set of parameters, this array contains a
% subset to run
% name   : the name given to run_setup_hypercube when setting up the run
% keep_traj: if true, then keep the trajectory (which makes huge files and
% is false by default)
%=========================================================================%
function run_model_hypercube(mypars, name, keep_traj)

    addpath('functions');
    
    if nargin < 3
        keep_traj = false;
    end
    
    % Load in the ranges
    config = run_setup_hypercube_config(name, 0, 0);
    dout = ['results_hypercube_', config.name];
    clear config;
    
    load(fullfile(dout, 'cube.mat'), 'config');
    
    rng(config.seed_swap);
    seeds = randi(2^32 - 1, [config.num_pars, 1]);

    for i = mypars
        disp(['par set: ', num2str(i), ' ']);tic;
        rng(seeds(i));
        
        % Initialise the network for ode modelling
        net = class_network;
        net.radius = config.radius;
        net.gmean = config.pars(i, 2);
        net.initialise(config.model);
        
        
        [gl_all, pops_all, assort_all] = ...
            swapping_algorithm(net.conns, ...
                               net.index(:,2:end), ...
                               config.pars(i, 3:end), ...
                               config.direction, config.method_sort, config.method_swap, config.heat_info, config.alpha);
                           
        swap_its = length(assort_all);
        
        % Set gkatp (gl) based on the swapping algorithm to the populations
        assort = assort_all(end);
        net.sys.gl = gl_all(:,end);
        pops = pops_all(:,end);
        
        % Set initial conditions
        random_initial_conditions = (1 + randn(length(net.sys.y0),1)/config.ric_scale);
        net.sys.y0 = net.sys.y0  .* random_initial_conditions;
        
        
        net.sys.G = config.pars(i,1);
        net.run_ode(config.Tmax);
        net.sys.run_stats(double(pops));
        if ~keep_traj
            net.sys.y = [];
            net.sys.t = [];
        end
        
        % Keep some info
        gl = net.sys.gl;
        gconns = net.gconns;
        pvals = config.pars(i,:);
        
        % Save
        save(fullfile(dout, ['out_', num2str(i), '.mat']), 'net', 'pops', ...
                             'gl', 'gconns', 'pvals', 'assort', 'swap_its', '-v7.3');
        disp(toc);
    end
end
