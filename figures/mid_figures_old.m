%% Initialise
clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
addpath(fullfile('..','functions_netgen'));

fn_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'cube.mat'));
fn_lattice_config = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'cube.mat'));
srk_netgen_config = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'cube.mat'));
srk_lattice_config = load(fullfile('..', 'results_hypercube_attempt_srk_G_mid', 'cube.mat'));

fn_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_gp.mat'));
fn_lattice_results = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_gp.mat'));
srk_netgen_results = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_gp.mat'));
srk_lattice_results = load(fullfile('..', 'results_hypercube_attempt_srk_G_mid', 'out_gp.mat'));

dout = 'mid_figures_old';

%% Trajectories FN Lattice
fn_lattice_q = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_lattice_q.net.sys.t_mean, fn_lattice_q.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_lattice_q.net.sys.t_mean, fn_lattice_q.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ko', 'filled');

c = (1-max([round(fn_lattice_q.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_q.png'));


fn_lattice_a1 = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_3.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_lattice_a1.net.sys.t_mean, fn_lattice_a1.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_lattice_a1.net.sys.t_mean, fn_lattice_a1.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ks', 'filled');

c = (1-max([round(fn_lattice_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_lattice_a1.net.sys.pk_t, fn_lattice_a1.net.sys.pk_locs, fn_lattice_a1.net.sys.pops);
axis tight
xlim([0,500]);
xticks([0,500]);
xticklabels([0,500]);


c = (1-max([round(fn_lattice_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1_raster.png'));





fn_lattice_a2 = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_7.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_lattice_a2.net.sys.t_mean, fn_lattice_a2.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_lattice_a2.net.sys.t_mean, fn_lattice_a2.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'kd', 'filled');

c = (1-max([round(fn_lattice_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a2.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_lattice_a2.net.sys.pk_t, fn_lattice_a2.net.sys.pk_locs, fn_lattice_a2.net.sys.pops);
axis tight
xlim([0,500]);
xticks([0,500]);
xticklabels([0,500]);


c = (1-max([round(fn_lattice_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a2_raster.png'));

%% FN Lattice
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_lattice_results.results.X_pred;
Y = fn_lattice_results.results.Y_pred;
Z = fn_lattice_results.results.pks_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_lattice_q.assort, fn_lattice_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_lattice_a1.assort, fn_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_lattice_a2.assort, fn_lattice_a2.pvals(1), 200, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_peaks.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_lattice_results.results.ord_p1_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [0.7, 0.7], 'k--', 'linewidth', 2);
contour(X,Y,Z, [0.8, 0.8], 'k--', 'linewidth', 2);
contour(X,Y,Z, [0.9, 0.9], 'k--', 'linewidth', 2);
colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_lattice_q.assort, fn_lattice_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_lattice_a1.assort, fn_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_lattice_a2.assort, fn_lattice_a2.pvals(1), 200, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_order_p1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_lattice_results.results.ord_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);

colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_lattice_q.assort, fn_lattice_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_lattice_a1.assort, fn_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_lattice_a2.assort, fn_lattice_a2.pvals(1), 200, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_order_p2.png'));

%% Trajectories SRK Lattice
srk_lattice_q = load(fullfile('..', 'results_hypercube_attempt_srk_G_mid', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_lattice_q.net.sys.t_mean/60000, srk_lattice_q.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_lattice_q.net.sys.t_mean/60000, srk_lattice_q.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0, 1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'ko', 'filled');

c = (1-max([round(srk_lattice_q.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_traj_q.png'));


srk_lattice_a1 = load(fullfile('..', 'results_hypercube_attempt_srk_G_mid', 'out_3.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_lattice_a1.net.sys.t_mean/60000, srk_lattice_a1.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_lattice_a1.net.sys.t_mean/60000, srk_lattice_a1.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0, 1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'ks', 'filled');

c = (1-max([round(srk_lattice_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_traj_a1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_lattice_a1.net.sys.pk_t/60000, srk_lattice_a1.net.sys.pk_locs, srk_lattice_a1.net.sys.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_lattice_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_traj_a1_raster.png'));





srk_lattice_a2 = load(fullfile('..', 'results_hypercube_attempt_srk_G_mid', 'out_2.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_lattice_a2.net.sys.t_mean/60000, srk_lattice_a2.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_lattice_a2.net.sys.t_mean/60000, srk_lattice_a2.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0,1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'kd', 'filled');

c = (1-max([round(srk_lattice_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_traj_a2.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_lattice_a2.net.sys.pk_t/60000, srk_lattice_a2.net.sys.pk_locs, srk_lattice_a2.net.sys.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_lattice_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_traj_a2_raster.png'));

%% SRK Lattice
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_lattice_results.results.X_pred;
Y = srk_lattice_results.results.Y_pred;
Z = srk_lattice_results.results.pks_pred;
Zp1 = srk_lattice_results.results.pks_p1_pred;
Zp2 = srk_lattice_results.results.pks_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(srk_lattice_q.assort, srk_lattice_q.pvals(1), 200, 'ko', 'filled');
scatter(srk_lattice_a1.assort, srk_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(srk_lattice_a2.assort, srk_lattice_a2.pvals(1), 200, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_peaks.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = srk_lattice_results.results.ord_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0,1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(srk_lattice_q.assort, srk_lattice_q.pvals(1), 200, 'ko', 'filled');
scatter(srk_lattice_a1.assort, srk_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(srk_lattice_a2.assort, srk_lattice_a2.pvals(1), 200, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_order.png'));

%% Trajectories FN Netgen
fn_netgen_q = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_3.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_q.net.t_mean, fn_netgen_q.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_q.net.t_mean, fn_netgen_q.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'ko', 'filled');

c = (1-max([round(fn_netgen_q.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_q.png'));


fn_netgen_a1 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a1.net.t_mean, fn_netgen_a1.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a1.net.t_mean, fn_netgen_a1.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'ks', 'filled');

c = (1-max([round(fn_netgen_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a1.net.pk_t, fn_netgen_a1.net.pk_locs, fn_netgen_a1.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1_raster.png'));

fn_netgen_a2 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_2.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a2.net.t_mean, fn_netgen_a2.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a2.net.t_mean, fn_netgen_a2.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'kd', 'filled');

c = (1-max([round(fn_netgen_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a2.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a2.net.pk_t, fn_netgen_a2.net.pk_locs, fn_netgen_a2.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a2_raster.png'));

fn_netgen_a3 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_4.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a3.net.t_mean, fn_netgen_a3.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a3.net.t_mean, fn_netgen_a3.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'kp', 'filled');

c = (1-max([round(fn_netgen_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a3.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a3.net.pk_t, fn_netgen_a3.net.pk_locs, fn_netgen_a3.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a3_raster.png'));

fn_netgen_a4 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_5356.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a4.net.t_mean, fn_netgen_a4.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a4.net.t_mean, fn_netgen_a4.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'k^', 'filled');

c = (1-max([round(fn_netgen_a4.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a4.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a4.net.pk_t, fn_netgen_a4.net.pk_locs, fn_netgen_a4.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a4.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a4_raster.png'));

fn_netgen_a5 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_49.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a5.net.t_mean, fn_netgen_a5.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a5.net.t_mean, fn_netgen_a5.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'k>', 'filled');

c = (1-max([round(fn_netgen_a5.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a5.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a5.net.pk_t, fn_netgen_a5.net.pk_locs, fn_netgen_a5.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a5.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a5_raster.png'));

fn_netgen_a6 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_100.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a6.net.t_mean, fn_netgen_a6.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a6.net.t_mean, fn_netgen_a6.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([3000, 3500, -3, 3]);
xticks([3000,3500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(3020, 2.4, 150,'kv', 'filled');

c = (1-max([round(fn_netgen_a6.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a6.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a6.net.pk_t, fn_netgen_a6.net.pk_locs, fn_netgen_a6.net.pops);
axis tight
xlim([3000,3500]);
xticks([3000,3500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a6.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a6_raster.png'));

%% FN Netgen
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_netgen_results.results.X_pred;
Y = fn_netgen_results.results.Y_pred;
Z = fn_netgen_results.results.pks_pred;
Zp1 = fn_netgen_results.results.pks_p1_pred;
Zp2 = fn_netgen_results.results.pks_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'kp', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 200, 'k^', 'filled');
scatter(fn_netgen_a5.assort, fn_netgen_a5.pvals(1), 200, 'k>', 'filled');
scatter(fn_netgen_a6.assort, fn_netgen_a6.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_peaks.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_netgen_results.results.ord_p1_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
contour(X,Y,Z, [0.7, 0.7], 'k--', 'linewidth', 2);
contour(X,Y,Z, [0.9, 0.9], 'k--', 'linewidth', 2);
colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'kp', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 200, 'k^', 'filled');
scatter(fn_netgen_a5.assort, fn_netgen_a5.pvals(1), 200, 'k>', 'filled');
scatter(fn_netgen_a6.assort, fn_netgen_a6.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_order_p1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_netgen_results.results.ord_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
contour(X,Y,Z, [0.7, 0.7], 'k--', 'linewidth', 2);
contour(X,Y,Z, [0.9, 0.9], 'k--', 'linewidth', 2);
colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'kp', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 200, 'k^', 'filled');
scatter(fn_netgen_a5.assort, fn_netgen_a5.pvals(1), 200, 'k>', 'filled');
scatter(fn_netgen_a6.assort, fn_netgen_a6.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_order_p2.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_netgen_results.results.pks_p1_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'kp', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 200, 'k^', 'filled');
scatter(fn_netgen_a5.assort, fn_netgen_a5.pvals(1), 200, 'k>', 'filled');
scatter(fn_netgen_a6.assort, fn_netgen_a6.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_peaks_p1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = fn_netgen_results.results.pks_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'kp', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 200, 'k^', 'filled');
scatter(fn_netgen_a5.assort, fn_netgen_a5.pvals(1), 200, 'k>', 'filled');
scatter(fn_netgen_a6.assort, fn_netgen_a6.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_peaks_p2.png'));

%% Trajectories SRK Netgen
srk_netgen_q = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_102.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_q.net.t_mean/60000, srk_netgen_q.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_q.net.t_mean/60000, srk_netgen_q.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0, 1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'ko', 'filled');

c = (1-max([round(srk_netgen_q.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_q.png'));


srk_netgen_a1 = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_8.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_a1.net.t_mean/60000, srk_netgen_a1.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_a1.net.t_mean/60000, srk_netgen_a1.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0, 1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'ks', 'filled');

c = (1-max([round(srk_netgen_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_netgen_a1.net.pk_t/60000, srk_netgen_a1.net.pk_locs, srk_netgen_a1.net.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_netgen_a1.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a1_raster.png'));

srk_netgen_a2 = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_108.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_a2.net.t_mean/60000, srk_netgen_a2.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_a2.net.t_mean/60000, srk_netgen_a2.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0,1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'kd', 'filled');

c = (1-max([round(srk_netgen_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a2.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_netgen_a2.net.pk_t/60000, srk_netgen_a2.net.pk_locs, srk_netgen_a2.net.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_netgen_a2.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a2_raster.png'));

srk_netgen_a3 = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_a3.net.t_mean/60000, srk_netgen_a3.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_a3.net.t_mean/60000, srk_netgen_a3.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0,1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'k^', 'filled');

c = (1-max([round(srk_netgen_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a3.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_netgen_a3.net.pk_t/60000, srk_netgen_a3.net.pk_locs, srk_netgen_a3.net.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_netgen_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a3_raster.png'));

srk_netgen_a4 = load(fullfile('..', 'results_netgen_attempt_srk_G_mid', 'out_104.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_a4.net.t_mean/60000, srk_netgen_a4.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_a4.net.t_mean/60000, srk_netgen_a4.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0,1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'kv', 'filled');

c = (1-max([round(srk_netgen_a4.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a4.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_netgen_a4.net.pk_t/60000, srk_netgen_a4.net.pk_locs, srk_netgen_a4.net.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_netgen_a4.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a4_raster.png'));
%% SRK Netgen
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_netgen_results.results.X_pred;
Y = srk_netgen_results.results.Y_pred;
Z = srk_netgen_results.results.pks_pred;
Zp1 = srk_netgen_results.results.pks_p1_pred;
Zp2 = srk_netgen_results.results.pks_p2_pred;
pcolor(X,Y,Z);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(srk_netgen_q.assort, srk_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(srk_netgen_a1.assort, srk_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(srk_netgen_a2.assort, srk_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(srk_netgen_a3.assort, srk_netgen_a3.pvals(1), 200, 'k^', 'filled');
scatter(srk_netgen_a4.assort, srk_netgen_a4.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_peaks.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
Z = srk_netgen_results.results.ord_pred;
pcolor(X,Y,Z);
%contour(X,Y,Z, [0.9, 0.9], 'k--', 'linewidth', 2);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0,1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

scatter(srk_netgen_q.assort, srk_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(srk_netgen_a1.assort, srk_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(srk_netgen_a2.assort, srk_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(srk_netgen_a3.assort, srk_netgen_a3.pvals(1), 200, 'k^', 'filled');
scatter(srk_netgen_a4.assort, srk_netgen_a4.pvals(1), 200, 'kv', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_order.png'));