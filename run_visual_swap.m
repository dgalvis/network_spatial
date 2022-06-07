% clear;clc;restoredefaultpath;close all;
% addpath('functions');
% addpath('results_assort_both_global_1');
% load('swap_1.mat');
% 
% % 1 and 2 global, alpha = 1
% 
% assort = assort{1};
% pops = logical(pops{1});
% net = class_network;
% net.initialise;
% locs = net.index(:,2:4);
% conns = net.conns;
% dists = distances(graph(conns));
% %%
% figure();hold all;
% 
% 
% x = find(assort == max(assort));
% for i =1:length(assort)
%     clf;hold all; 
%     p1 = pops(:,i);
%     p2 = ~p1;
%     p1_locs = locs(p1,:);
%     p2_locs = locs(p2,:);
%     scatter3(p1_locs(:,1),p1_locs(:,2),p1_locs(:,3),200,'b', 'filled');
%     scatter3(p2_locs(:,1),p2_locs(:,2),p2_locs(:,3),'k', 'filled');
%    
%     
%     view([-20,45]);
%     pause;
% end
%%
clear;clc;restoredefaultpath;close all;
addpath('functions');
addpath('results_assort_netgen_forward_global_2');
load('swap_1.mat');


assort = assort{1};
pops = pops{1};
figure();
for i = 1:10:length(assort)
    clf;
    p = logical(pops(:,i));
    G = graph(config.net_conns(p,p));
    G2 = graph(config.net_conns);
    subplot(211);hold all;
    plot(G, 'layout', 'force', 'NodeColor', 'b');
    subplot(212);hold all;
    h = plot(G2, 'layout', 'force', 'NodeColor', 'b', 'MarkerSize', 2);
    highlight(h, find(p), 'NodeColor', 'k', 'MarkerSize', 4);
    pause;
end