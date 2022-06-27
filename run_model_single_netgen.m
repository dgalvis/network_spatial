%=========================================================================%
% Function: run_model_single_netgen
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
% 11/05/2022
% code addition for Fitzhugh Nagumo Model
%
% This code runs the swapping algorithm to distribute population 1 and 2
% throughout the islet then runs the ode and saves the result. Uses
% run_model_single_config(). It will run a subset of the derived hypercube
% parameters (see the config file).
%
% The difference between this and run_model is that it only runs the
% swapping algorithm once from an initial uniformly distributed network,
% then it runs across all the swaps and for all the parameters. It also
% uses the same initial conditions for the network each time.
%
% Note: run_setup_single.m must be run first!!!
%
% Parameters
% ==========
% mypars : To distribute the full set of parameters, this array contains a
% subset to run
% name   : the name given to run_setup_single when setting up the run
% keep_traj: if true, then keep the trajectory (which makes huge files and
% is false by default)
%=========================================================================%
function run_model_single_netgen(mypars, name, keep_traj)

    addpath('functions');
    
    if nargin < 3
        keep_traj = false;
    end
        
    config = run_setup_single_netgen_config(name, 0, 0);
    dout = ['results_single_netgen_', config.name];
    clear config;
    
    
    load(fullfile(dout,'parameters.mat'), 'config', 'gl_all', 'pops_all', 'assort_all', 'random_initial_conditions');

    swap_its = length(assort_all);
    for i = mypars
        disp(['iteration: ', num2str(i), ' ']);tic;
        if (i > swap_its)
            disp('iteration skipped see config.inc');
            continue
            
        else   
            for j = 1:config.num_pars

                if (sum(i == (1:config.inc:config.pars(j,4))) == 0)
                    disp('iteration skipped see config.inc');
                    continue
                end
              % Initialise the network for ode modelling
                if strcmp(config.model, 'srk')
                    net = class_srk;
                elseif strcmp(config.model, 'fn')
                    net = class_fn;
                end      
                net.make_network(config.net_conns * config.pars(j, 2));
                
                % Initial condition
                assort = assort_all(i);
                net.gl = gl_all(:,i);
                pops = pops_all(:,i);
                net.y0 = net.y0  .* random_initial_conditions;


                net.G = config.pars(j,1);
                net.run_ode(config.Tmax);
                net.run_stats(double(pops));
                
                if ~keep_traj
                    net.y = [];
                    net.t = [];
                end
                
                gl = net.gl;
                gconns = net.gconns;
                pvals = config.pars(j,:);

                save(fullfile(dout, ['out_', num2str(i), '_', num2str(j),  '.mat']), 'net', ...
                                     'gl', 'gconns', 'pvals', 'assort', 'swap_its', '-v7.3');
                disp(toc);
            end
        end
    end
end
