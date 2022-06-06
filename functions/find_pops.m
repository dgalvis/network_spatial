%=========================================================================%
% Function: find_pops
% Author: Daniel Galvis
%
% 03/03/2021
% code generation
%
% This function uses the connections and which nodes are in population 1 vs
% population 2 to figure out, for each node, how many connections it has to
% each population
%
% Parameters
% ==========
% connections : square array of number of nodes ^2 of bools
%     (1) locations of connections for assessing assortativity
% in : array of number of nodes x 1
%     (1) population 1 -> 1
%     (2) population 2 -> 0
%
%
% Returns
% =======
% pop1: number of pop1 nodes x 1
%       number or fraction of pop1 connections to pop1
% pop2: number of pop2 nodes x 1
%       number or fraction of pop2 connections to pop2
%=========================================================================%
function [pop1, pop2] = find_pops(connections, in)


    not_in = ~in;

    
    pop1 = full(sum(connections(in, in), 2));
    % for each node, find the number of connections to population 1
    %pop1 = connections * in;    
     % This gives the number of connections pop1 has to pop1 only
    %pop1 = pop1(in);  
    
    % for each node, find the number of connections to population 2
    pop2 = connections * (not_in);
    % and the number of connections pop2 has to pop2 only
    pop2 = pop2(not_in);
    

        

end