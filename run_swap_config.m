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
    out.num_attempts = 1; % number of attempts networks to run
    out.iterations = 10000;  % max iterations of swapping algorithm
                               % (in practice convergence is faster)
    
    out.direction = true;    % true - assort
                             % false - disassort
   
    out.both = true;        % true - go out.direction then the opposite
                             % false - only go out.direction
    
    
    out.radius = 5.55;       % radius of the islet network
        
    
    out.seed = 1;            % random number generator seed

    
    out.method_sort = 'local'; % global or local sortedness
    out.method_swap = 'local'; % global or local swapping
    out.alpha  = 1; %[0,1] - 0 - swap pairs random
                    %        1 - swap pairs depend on radius
                    %        (0,1) - in between
                    
    out.name = 'both_5';   % directory will be called:
                                % results_assort_{out.name}
    
end
