%=========================================================================%
% Function: swapper
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% This code takes in a network with two populations of cells and swaps
% cells between populations to increase (decrease) the spatial
% assortativity.
%
% PARAMETERS
% ==========
% iterations  : a float, number of swaps to try
%               if convergence occurs the result may return fewer
% population  : an array of size nodes x 1
%               this is the initial population 1 ids
%               pop1 = 1, pop2 = 0
% connections : an array of size nodes x nodes
%               1 - if connection, 0 - otherwise
% locations   : an array of size nodes x 3
%               spatial locations in 3 space of the nodes
% direction   : true - increase assortativity
%               false - decrease assortativity
% method      : local - local sortedness
%               global - global sortedness
% alpha       : [0,1] - 0 - swap pairs random
%                       1 - swap pairs depend on radius
%                       (0,1) - in between
%
% Returns
% =======
% population_all : an array of size nodes x iterations (or the max until
%                  convergence), population ids
% assort_all     : an array of size iterations (or max) x 1
%                  assortativity values for each population in
%                  population_all
%=========================================================================%




function [population_all, assort_all] = swapper(iterations, population, connections, locations, direction, method, alpha)
    
    if nargin < 6
        method = 'local';
    end
    if nargin < 7
        alpha = 1; % 1 - total dependence on shell
                   % 0 - completely random
    end


    if iterations < 0
        direction = ~direction;
        iterations = - iterations;
    end

    
    % I'm Ricky Bobby, I wanna go fast!
    connections = sparse(connections);
    
    % for global assortativity
    if strcmp(method, 'global')
        dists = sparse(triu(distances(graph(connections))));
    end
    
    % iteration counter (i = 1 means 0 iterations, sorry)
    its = 1;   
    
    % Define arrays
    population_all = zeros(length(connections), iterations+1);
    assort_all = zeros(1, iterations+1);
    
    % The first iteration is just the initial population
    population_all(:,1) = population;    
    
    % Find full assortativity, this is always returned by assort_all
    if strcmp(method, 'local')
        [pop1, pop2] = find_pops(connections, population);
        assort_all(1) =  assort_measure(pop1, pop2, connections, population); 
    elseif strcmp(method, 'global')
        assort_all(1) = global_assort_measure(dists, population);
    end
        
    
    % Identify shells of the spherical networks and which nodes are in
    % which shells
    num_bins = 8;
    node_dists =(vecnorm(locations, 2, 2));
    
    [~, shell_centers] = hist(node_dists, num_bins);
    
    shell_ends = shell_centers + (max(node_dists) - shell_centers(end)) + 1e-4;
    shell_ends = [0, shell_ends, Inf];
    
    node_bins = node_dists < shell_ends;
    node_bins = ~node_bins;
    node_bins = sum(node_bins, 2);

    
    % A very nice while loop
    while its < (iterations+1)
     
        % Find idx within population of pop1 and pop2
        pop1_idx = find(population);
        pop2_idx = find(~population);        
        
        % Find probabilities for all the combinations of pop1 and pop2
        % Number of pop1 and pop2 cells in each shell
        pop1_node_bins=node_bins(population);
        pop1_shell_bins = sum(pop1_node_bins == 1:num_bins);
        
        pop2_node_bins=node_bins(~population);
        pop2_shell_bins=sum(pop2_node_bins == 1:num_bins);

        % Probability weights for each shell pop1 and pop2
        pop1_shell_probs = 1 ./ pop1_shell_bins;
        pop2_shell_probs = 1 ./ pop2_shell_bins;
        
        pop1_node_list = [(1:sum(population))',pop1_shell_probs(pop1_node_bins)'];
        pop2_node_list = [(1:sum(~population))',pop2_shell_probs(pop2_node_bins)'];
        
        [m,n] = ndgrid(pop1_node_list(:,1), pop2_node_list(:,1));
        [m2, n2] = ndgrid(pop1_node_list(:,2), pop2_node_list(:,2));
        
        joint_prob = m2(:) .* n2(:);
        mean_joint_prob = mean(joint_prob);
        no_prob = mean_joint_prob * ones(length(m2(:)), 1);
  
        
        total_prob = alpha * joint_prob + (1 - alpha) * no_prob;
        combination_list = [m(:), n(:), total_prob];
       
        
        line_up = cumsum(combination_list(:,end));
        num_combos = length(line_up);
        
        
        % Randomly select a node from each population until we find on that
        % increases assortativity
        success = false;
        
        if strcmp(method, 'local')
            % Find the number of connections for pop1 onto pop1
            % and the number of connections for pop2 onto pop2
            [pop1, pop2] = find_pops(connections, population);
            % use that to calculate full assortativity for both
            [as,~,~] =  assort_measure(pop1, pop2, connections, population);
        elseif strcmp(method, 'global')
            as = global_assort_measure(dists, population);
        end
        for i = 1:num_combos
            cool_with_this_rando = rand * line_up(end);
            idx = sum(cool_with_this_rando > line_up) + 1;
            
            node1 = pop1_idx(combination_list(idx,1));
            node2 = pop2_idx(combination_list(idx,2));
            nodes = [node1, node2];
            
            % Swapped nodes
            population_aux = population;
            population_aux(nodes(1)) = population(nodes(2));
            population_aux(nodes(2)) = population(nodes(1));
                
            if strcmp(method, 'local')
                % and in the swapped version
                [pop1_aux, pop2_aux] = find_pops(connections, population_aux);
                [as_aux,~,~] = assort_measure(pop1_aux, pop2_aux, connections, population_aux);    
            elseif strcmp(method, 'global')
                as_aux = global_assort_measure(dists, population_aux);
            end
            
            % if assortativity increases (when forward) then keep
            % if assortativity decreases (when backward) then keep
            % otherwise increment fail counter and move on
            check1 = (as_aux <= as) && direction;
            check2 = (as_aux >= as) && ~direction;
            if (~check1) && (~check2)
                assort = as_aux;
                success = true;
                population = population_aux;
                break;
            end
            
            % if a node combo does not work, set it's probability weight to
            % 0 so it is not chosen again.
            combination_list(idx, end) = 0;
            line_up = cumsum(combination_list(:,end));
            
        end
        if success
            % increment i
            its = its + 1;    
            % save the output for this increment of i
            population_all(:,its) = population;
            assort_all(its) = assort;
        else
            break;
        end
    end
    % If the max iterations could not be met, reduce the arrays
    population_all = population_all(:,1:its);
    assort_all = assort_all(:,1:its);
end
    