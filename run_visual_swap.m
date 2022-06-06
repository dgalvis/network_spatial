clear;clc;restoredefaultpath;close all;
addpath('functions');
addpath('results_assort_both_global_1');
load('swap_1.mat');

% 1 and 2 global, alpha = 1

assort = assort{1};
pops = logical(pops{1});
net = class_network;
net.initialise;
locs = net.index(:,2:4);
conns = net.conns;
dists = distances(graph(conns));
%%
figure();hold all;


x = find(assort == max(assort));
for i =1:length(assort)
    clf;hold all; 
    p1 = pops(:,i);
    p2 = ~p1;
    p1_locs = locs(p1,:);
    p2_locs = locs(p2,:);
    scatter3(p1_locs(:,1),p1_locs(:,2),p1_locs(:,3),200,'b', 'filled');
    scatter3(p2_locs(:,1),p2_locs(:,2),p2_locs(:,3),'k', 'filled');
   
    
    view([-20,45]);
    pause;
end

