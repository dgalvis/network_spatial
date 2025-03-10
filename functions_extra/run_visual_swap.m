clear;clc;restoredefaultpath;close all;
addpath('functions');
load(fullfile('results_directory', 'results_assort_forward_testheat7', 'swap_1.mat'));

% 1 and 2 global, alpha = 1
test_id = 6;

assort = assort{test_id};
pops = logical(pops{test_id});
net = class_network;
net.initialise;
locs = net.index(:,2:4);
conns = net.conns;
dists = distances(graph(conns));

figure();hold all;


x = find(assort == max(assort));
for i = 1:length(assort)
    clf;hold all; 
    p1 = pops(:,i);
    p2 = ~p1;
    p1_locs = locs(p1,:);
    p2_locs = locs(p2,:);
    subplot(211);hold all;
    scatter3(p1_locs(:,1),p1_locs(:,2),p1_locs(:,3),200,'b', 'filled');
    scatter3(p2_locs(:,1),p2_locs(:,2),p2_locs(:,3),'k', 'filled');
    view([40 + i,40]);
    subplot(212);hold all;
    title('sortedness');
    plot(1:length(assort), assort, 'color', [0.5, 0.5, 0.5], 'linewidth', 1)
    plot(1:i, assort(1:i), 'k', 'linewidth', 2);
    pause(0.1);
end
%%
clear;clc;restoredefaultpath;%close all;
addpath('functions');
load(fullfile('results_directory', 'results_assort_netgen_forward_WS_locglo_3', 'swap_1.mat'));

test_id = 3;
assort = assort{test_id};
pops = pops{test_id};
connections = config.net_conns;
figure();
for i = length(assort)
    clf;
    p = logical(pops(:,i));
    G = graph(config.net_conns(p,p));
    G2 = graph(config.net_conns);
    subplot(221);hold all;
    plot(G, 'layout', 'force', 'NodeColor', 'b');
    subplot(222);hold all;
    h = plot(G2, 'layout', 'force', 'NodeColor', 'b', 'MarkerSize', 2);
    highlight(h, find(p), 'NodeColor', 'k', 'MarkerSize', 4);
    subplot(223);hold all;
    p1_conns = sum(connections(p,:), 2);
    p2_conns = sum(connections(~p,:), 2);
    
    
    histogram(p1_conns, linspace(0, max(sum(connections)), 10), 'normalization', 'probability');
    histogram(p2_conns, linspace(0, max(sum(connections)), 10), 'normalization', 'probability');
    legend('p1', 'p2');
    xlabel('degree');
    ylabel('probability')
    
    subplot(224);hold all;
    title('sortedness');
    plot(1:length(assort), assort, 'color', [0.5, 0.5, 0.5], 'linewidth', 1)
    plot(1:i, assort(1:i), 'k', 'linewidth', 2);
    pause;
end