clear;clc;close all;restoredefaultpath;
addpath('../functions');


dout = 'figures';
Tmax = 400000;
%% 2-Coupled

%G = 0.45, gl = [100;60]
%gcoup = 0, cell 1 quiet, cell 2 burst
%gcoup = 2, cell 1 and 2 active, 2:1 resonance
%gcoup = 10, cell 1 and 2 coordinated

% G = 0.6
% gcoup = 0; both active, different freq and phases
% gcoup = 2; both active, some sort of resonance maybe? (and sometimes
% coordinated??), looks like 3:2
% gcoup = 10; coordinated

gcoup = 2;
gconns = [0 gcoup ; gcoup 0];
net = class_srk;
net.make_network(gconns);
net.y0 = net.y0 .* (1 + randn(size(net.y0)) /6);
net.gl = [100;60];
net.G  = 0.6;
net.run_ode(Tmax);
net.plot_me;

figure();hold all;
plot(net.t/60000, net.y(:,3), 'k', 'linewidth', 2);
plot(net.t/60000, net.y(:,6), 'b', 'linewidth', 2);
axis([1,6, 0, 1]);
xticks([1, 6]);
xticklabels([0,5]);
yticks([0, 1]);
yticklabels([0, 1]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'two_coupled_3_2_res.png'));

%% 3 chain

% gcoup1 = gcoup2 = 10; (This is like middle coupling, high sortedness)
% G = 0.35 - quiet
% G = 0.37 - 2:1
% G = 0.4  - messy
% G = 0.45 - coordinated

% gcoup1 = gcoup2 = 12; (This is like stronger coupling)
% G = 0.35 - quiet
% G = 0.36 - quiet or coordinated based on IC
% G = 0.4  - coordinated

% gcoup1 = gcoup2 = 50; (This is like strong coupling
% G = 0.4 quiet
% G - 0.45 quiet or coordinated
% G - 0.5 coordinated


% p2 - p2 - p1 (network architecture)
% gcoup1 = 10; %p2 - p2
% gcoup2 = 10; %p2 - p1
% gconns = [0 gcoup1 0; gcoup1 0 gcoup2;0 gcoup2 0];
% net = class_srk;
% net.make_network(gconns);
% net.y0 = net.y0 .* (1 + randn(size(net.y0)) /6);
% net.gl = [100;100;60];
% net.G  = 0.4;
% net.run_ode(Tmax);
% net.plot_me;

