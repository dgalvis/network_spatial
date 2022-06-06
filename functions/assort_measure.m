%=========================================================================%
% Function: assort_measure
% Author: Daniel Galvis
%
% 03/03/2021
% code generation
%
% Calculate the assortativity for the full network
%
%
% Parameters
% ==========
% pop1 : size of population 1 x 1
%     (1) number of connections each cell in pop1 has onto pop1
% pop2 : size of population 2 x 1
%     (1) number of connections each cell in pop1 has onto pop2
%     (gotten from find_pops with scale and full both false)
% connections : square array of number of nodes ^2 of bools
%     (1) locations of connections for assessing assortativity
% in : array of number of nodes x 1
%     (1) population 1 -> 1
%     (2) population 2 -> 0
% debias : bool (assume that outside the lattice there is a sea of pop2
% cells if true. This prevents the cluster of pop1 from always being on the
% boundary.
%
% Returns
% =======
% assortativity: double full network assorativity [-1,1]
%=========================================================================%

function [assortativity, assort_pop1, assort_pop2] = assort_measure(pop1, pop2, connections, in, debias)

    if nargin < 5
        debias = true;
    end

    num_conns = full(sum(connections, 2));
    max_conns = max(num_conns);
    
    % Population 1 assortativity
    if debias
        pop1 = pop1 / max_conns;
    else
        pop1_num_conns = num_conns(in);
        pop1 = pop1 ./ pop1_num_conns;
    end
    
    % Population 2 assortativity
    not_in = ~in;
    pop2_num_conns = num_conns(not_in);
    
    if debias
        pop2 = ((max_conns - pop2_num_conns) + pop2) / max_conns;
    else
        pop2 = pop2 ./ pop2_num_conns;
    end
    
    % We take the mean of means so that the algorithm is not biased to the
    % bigger subpopulation
    assort_pop1 = mean(pop1);
    assort_pop2 = mean(pop2);
    assortativity = (assort_pop1 + assort_pop2) - 1;

    
end