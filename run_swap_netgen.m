%=========================================================================%
% Function: run_swap_netgen
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
%
% Tests the assortativity algorithm using the parameters in
% run_swap_netgen_config. 
%
% Parameters
% ==========
% mypars : To distribute the full set of attempts and population fractions,
% this array says which attempts to run
% name : string, name of the file to save, directory chosen in config.
%
% note: use the functon concatenate_run_swaps.m to put together all the
% attempts from distributing all attempts. (see run_swap_concatenate.m).
%
% Returns
% =======
% pops : cell array which assigns all nodes to population 1 or 2
%      : dimension num_attempts x length(pop_frac) (see config)
%      : each entry is an array size num_nodes x assort iterations
%      : pop1 = 1, pop2 = 0
% assort : cell array with all assortativities added in
%        : same size as cell array pops
%        : each entry is one float with the assortativity of the network
%=========================================================================%

function [assort, pops] = run_swap_netgen(mypars, name)

    addpath('functions');        % need functions
    addpath('functions_netgen');
    config = run_swap_netgen_config();  % grab configuration parameters
    
    dout = ['results_assort_netgen_', config.name]; % name of the directory
    mkdir(dout);                             % make the directory
    
    
    rng(config.seed); % seed random number generator
    seeds = randi(2^32 - 1, ...
                  [config.num_attempts, ...
                   length(config.pop_frac)]); % use master seed to create
                                                % an individual seed
                                                % for each network
                                                                                
    rng(config.seed_netgen);  
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
         
    end             % initialise the network 
    

    assort = cell(config.num_attempts, ...
                  length(config.pop_frac)); % this holds assortativity values
              
    pops = cell(config.num_attempts, ...
                length(config.pop_frac)); % this holds the locations of the populations
                                          % 1 - pop1, 0 - pop2

    
    ct = 1;
    for j = 1:config.num_attempts % iterate over number of attempts
        for k = 1:length(config.pop_frac) % iterate over all pop1 fractions
            if sum(ct == mypars) % only run a subset of the attempts
                    rng(seeds(j, k)); % individual run seed
                    
                    % Run the swapping algorithm in direction
                    % config.direction
                    [~, pop_aux, assort_aux] = ...
                        swapping_algorithm(net, ...
                                           [], ...
                                           [config.pop_frac(k), config.iterations, 1, 0, 0, 0], ...
                                           config.direction, config.method_sort, config.method_swap, 0);
                    
                    % Maybe run algorithm in direction ~config.direction
                    if config.both           
                       [~, pop_aux_b, assort_aux_b] = ...
                         swapping_algorithm(net, ...
                                            [], ...
                                            [config.pop_frac(k), config.iterations, 1, 0, 0, 0], ...
                                            ~config.direction, config.method_sort, config.method_swap, 0, pop_aux(:,end)); 
                    else
                        pop_aux_b = [];
                        assort_aux_b = [];
                    end
                    
                    % populate the full array
                    pops{j, k} = [pop_aux, pop_aux_b];
                    assort{j, k} =  [assort_aux, assort_aux_b];
                    
            end
            ct = ct + 1;
        end
    end
    
    % save results
    fout = fullfile(dout, ['swap_', name]);
    save(fout, 'assort', 'pops', 'config');
end