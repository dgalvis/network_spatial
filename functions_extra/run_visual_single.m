clear;clc;restoredefaultpath;
idx=1;
addpath(['results_single_attempt_0', num2str(idx),'']);
load('out_concat.mat');



X = assort_concat;
Y = G_concat;
num_peaks = pks_concat;
num_p1_peaks = pks_p1_concat;
num_p2_peaks = pks_p2_concat;
ord = ord_concat;
p1_ord = ord_p1_concat;
p2_ord = ord_p2_concat;


figure('renderer', 'Painters');hold all;
subplot(311);
contourf(X,Y,num_peaks, 100,'EdgeColor', 'none');colorbar;
subplot(312);
contourf(X,Y,num_p1_peaks, 100,'EdgeColor', 'none');colorbar;
subplot(313);
contourf(X,Y,num_p2_peaks, 100,'EdgeColor', 'none');colorbar;

figure('renderer', 'Painters');hold all;
subplot(311);
contourf(X,Y,ord, 100,'EdgeColor', 'none');colorbar;
subplot(312);
contourf(X,Y,p1_ord, 100,'EdgeColor', 'none');colorbar;
subplot(313);
contourf(X,Y,p2_ord, 100,'EdgeColor', 'none');colorbar;