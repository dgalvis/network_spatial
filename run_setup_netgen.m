%=========================================================================%
% Function: run_setup_netgen
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% For parameters in run_setup_netgen_config, run a latin hypercube on the
% bounds. Save the result in config.pars inside the folder config.name in
% with the name cube.mat

% Parameters
% ==========
% seed     = seed for random number generator of hypercube
% name     = folder name for this run
% seed_swap = seed for run_model_hypercube.m (swapping and IC)
% seed_netgen = seed for network generation
%=========================================================================%

function pars = run_setup_netgen(name, seed, seed_swap, seed_netgen)
    addpath('functions');
    addpath('functions_netgen');
    
    % Load in the ranges
    config = run_setup_netgen_config(name, seed, seed_swap, seed_netgen);
    
    
    rng(config.seed);
    dout = ['results_netgen_', num2str(config.name)];
    mkdir(dout);

    
    % Only use latin hypercube for parameters that have different bounds
    hyp = [];
    if config.Gfracrng(2) ~= config.Gfracrng(1)
        hyp = [hyp, 1];
    end
    if config.gconnrng(2) ~= config.gconnrng(1)
        hyp = [hyp, 2];
    end
    if config.poprng(2) ~= config.poprng(1)
        hyp = [hyp, 3];
    end
    if config.itrng(2) ~= config.itrng(1)
        hyp = [hyp, 4];
    end    
     if config.gl1meanrng(2) ~= config.gl1meanrng(1)
        hyp = [hyp, 5];
    end
    if config.gl2meanrng(2) ~= config.gl2meanrng(1)
        hyp = [hyp, 6];
    end
    if config.gl1stdrng(2) ~= config.gl1stdrng(1)
        hyp = [hyp, 7];
    end
    if config.gl2stdrng(2) ~= config.gl2stdrng(1)
        hyp = [hyp, 8];
    end      
    
    % Latin Hypercube
    pars = lhsdesign(config.num_pars, length(hyp));
    
    % Put together latin hypercube and unvarying parameters
    pars2 = zeros(config.num_pars, 8);
    pars2(:, ismember(1:8, hyp)) = pars;
    pars2(:, ~ismember(1:8, hyp)) = 1;
    pars = pars2;
    
     % Change the ranges of the parameters
     pars(:,1) = (config.Gfracrng(2) - config.Gfracrng(1)) * pars(:,1) + config.Gfracrng(1);
     pars(:,2) = (config.gconnrng(2) - config.gconnrng(1)) * pars(:,2) + config.gconnrng(1);
     pars(:,3) = (config.poprng(2) - config.poprng(1)) * pars(:,3) + config.poprng(1);
     pars(:,4) = (config.itrng(2) - config.itrng(1)) * pars(:,4) + config.itrng(1);
     pars(:,5) = (config.gl1meanrng(2) - config.gl1meanrng(1)) * pars(:,5) + config.gl1meanrng(1);
     pars(:,6) = (config.gl2meanrng(2) - config.gl2meanrng(1)) * pars(:,6) + config.gl2meanrng(1);
     pars(:,7) = (config.gl1stdrng(2) - config.gl1stdrng(1)) * pars(:,7) + config.gl1stdrng(1);
     pars(:,8) = (config.gl2stdrng(2) - config.gl2stdrng(1)) * pars(:,8) + config.gl2stdrng(1);     

     % the iterations is an integer
     pars(:,4) = ceil(pars(:,4));
     
     % add to the config with all information
     config.pars = pars;
     
     
     % network generation
     rng(seed_netgen);
     
    conn_check = false;
    while ~conn_check 
         if strcmp(config.netgen_method, 'WS')
             net = watts_strogatz(config.num_nodes, config.num_conns / 2, config.rewiring_p);
         elseif strcmp(config.netgen_method, 'BA')
             seed_net = watts_strogatz(config.num_conns + 1, config.num_conns / 2, 0);
             net = barabasi_albert(config.num_nodes, config.num_conns / 2, seed_net);
             config.net_init = seed_net;
         end
         config.net_conns = net;
         
         if max(conncomp(graph(net))) == 1
             conn_check = true;
         end
         
    end
     
     % save
     fout = fullfile(dout, 'cube.mat');
     save(fout, 'config', '-v7.3');
end    
    