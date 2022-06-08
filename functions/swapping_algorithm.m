%=========================================================================%
% Function: swapping_algorithm
% Author: Daniel Galvis
%
% 03/03/2021
% code generation
%
% This function takes a set of nodes with given connectivity and runs a
% swapping algorithm to sort the nodes into two populations with a given
% assortativity (or disassortativity). The two populations are then
% assigned values from two distributions (bimodal and spatially non-random
% distribution of a parameter).
% 
% Parameters
% ==========
% connections : square array of logicals (network connections)
% pars: 1 x 4 array of parameters
%     (1) fraction of population 1
%     (2) max number of swaps (subject to that number being possible)
%     (3) output value for population 1 (mean)
%     (4) output value for population 2 (mean)
%     (5) output value for population 1 (std)
%     (6) output value for population 2 (std)
% direction: bool
%       true: run swapper forward (assort)
%       false: run swapper backward (disassort)
% method_sort      : local - local sortedness
%                  : global - global sortedness
% method_swap      : local - local swapping
%                  : global - global swapping
% alpha       : [0,1] - 0 - swap pairs random
%                       1 - swap pairs depend on radius
%                       (0,1) - in between           
% population array of logicals, optional
%      add in the initial population of 1 and 2 array
% Returns
% =======
% out : array length(connections) x number of iterations
%     The swapper determines which nodes are in population 1 and 2
%     Each node in population 1 gets output value for population 1
%     Each node in population 2 gets output value for population 2
%     Each column is an iteration of the swapping algorithm
% vals : array length(connections x number of iterations
%     Same as out, but with the population bools
%     Population 1 = 1
%     Population 2 = 0
% assort_all : array number of iterations x 1
%     This gives the full assortativity value for each swap iteration
%     Either the length is pars(2) or the maximum number before the swapper
%       gives up
%
%
%=========================================================================%

function [out, vals, assort_all] = swapping_algorithm(connections, locations, pars, direction, method_sort, method_swap, alpha, population)


    % Define important parameters
    num_nodes = length(connections);
    frac_pop = pars(1);
    iterations = pars(2);
    
    
    if nargin < 5
        method_sort = 'local';
    end
    if nargin < 6
        method_swap = 'global';
    end
    if nargin < 7
        alpha = 1; % 1 - total dependence on shell
                   % 0 - completely random
    end    
    if nargin < 8
        % How many nodes in population 1?
        num_pop = round(num_nodes * frac_pop);

        % Identify initial condition with population 1 uniformly distributed
        [~, idx] = sort(rand(num_nodes, 1));


        population = zeros(num_nodes, 1);
        population(idx(1:num_pop)) = 1;
        population = logical(population);
    end
     
    % Run the swapper
    [vals, assort_all] = swapper(iterations,  population, connections, locations, direction, method_sort, method_swap, alpha);
   
    % Assign values to population 1 and 2
    population1_vals = lognormals(pars(3), pars(5), [sum(vals(:,1)), 1]);
    population2_vals = lognormals(pars(4), pars(6), [sum(~vals(:,1)), 1]);
    
    population1_vals = [find(vals(:,1)), population1_vals];
    population2_vals = [find(~vals(:,1)), population2_vals];
    
    
    % Each swap also swaps the value so the distribution and values are
    % consistent across iterations
    out = zeros(size(vals));
    % With no iterations, just assign the random variables
    out(population1_vals(:,1),1) = population1_vals(:,2);
    out(population2_vals(:,1),1) = population2_vals(:,2);
    
    % For each swap iteration
    for i = 2:length(assort_all)
        
        % Find the node that switched to pop1 and to pop2
        switched_to_pop1 = find((vals(:, i) == 1) & (vals(:, i-1) == 0));
        switched_to_pop2 = find((vals(:, i) == 0) & (vals(:, i-1) == 1));
        
        
        % Find the index of each in the values arrays
        idx_pop1 = switched_to_pop2 == population1_vals(:,1);
        idx_pop2 = switched_to_pop1 == population2_vals(:,1);
        
        % Edit the first column so it reflects the swap
        population1_vals(idx_pop1,1) = switched_to_pop1;
        population2_vals(idx_pop2,1) = switched_to_pop2;
        
        % Assign values
        out(population1_vals(:,1),i) = population1_vals(:,2);
        out(population2_vals(:,1),i) = population2_vals(:,2);
        
        
    end
    vals = logical(vals);
    
    
end