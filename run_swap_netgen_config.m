%=========================================================================%
% Function: run_swap_netgen_config
% Author: Daniel Galvis
%
%
% Parameters for run_swap_netgen.m 
%
%=========================================================================%

function out = run_swap_netgen_config()


    out.pop_frac = 0.1;      % numbers in [0,1]
                             % can be a 1-D array 
    out.num_attempts = 1; % number of attempts networks to run
    out.iterations = 10000;  % max iterations of swapping algorithm
                               % (in practice convergence is faster)
    
    out.direction = true;    % true - assort
                             % false - disassort
   
    out.both = false;        % true - go out.direction then the opposite
                             % false - only go out.direction
    
    
    out.netgen_method = 'WS'; % 'WS' - watts_strogatz
                              % 'BA' - barabasi_albert
                              
    out.num_nodes = 1000; % number of nodes for general network
    out.num_conns = 12; % average degree of general network
    out.rewiring_p = 0.2; % for 'WS' only, ignored for 'BA'
        
    
    out.seed = 1;            % random number generator seed
    out.seed_netgen = 1;     % random number for network generation

    out.method = 'global'; % global or local sortedness
                    
    out.name = 'forward_global_2';   % directory will be called:
                                % results_assort_{out.name}
    
end