%=========================================================================%
% Function: run_swap_config
% Author: Daniel Galvis
%
%
% Parameters for run_swap.m 
%
%=========================================================================%

function out = run_swap_config()


    out.pop_frac = 0.1;      % numbers in [0,1]
                             % can be a 1-D array 
    out.num_attempts = 10; % number of attempts networks to run
    out.iterations = 10000;  % max iterations of swapping algorithm
                               % (in practice convergence is faster)
                               % does not include heat iterations
    
    out.direction = true;    % true - assort
                             % false - disassort
   
    out.both = false;        % true - go out.direction then the opposite
                             % false - only go out.direction
    
    
    out.radius = 5.55;       % radius of the islet network
        
    
    out.seed = 1;            % random number generator seed

    
    out.method_sort = 'local'; % global or local sortedness
    out.method_swap = 'local'; % global or local swapping
    
    % heat based method
    out.heat_info.heat_based = true; %active or not? if false, the others heat parameters don't matter
    out.heat_info.heat_count_max = 20;% how many times can I kick out of a local min or max
    out.heat_info.temp = 0.001; % temperature
    out.heat_info.max_iterations = 10000; % total number of iterations including the heat ones
    
    out.alpha  = 1; %[0,1] - 0 - swap pairs random
                    %        1 - swap pairs depend on radius
                    %        (0,1) - in between
                    
    out.name = 'forward_testheat6';   % directory will be called:
                                % results_assort_{out.name}
    
end
