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

dout = 'mid_figures';

% r = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_concat.mat'));
% for i = 1:1000
%     scatter(r.assort_concat(i), r.G_concat(i), 'k','filled');title(num2str(i));pause;
% end
%% Trajectories FN Lattice
net = class_network;
[~,idx] = sort(vecnorm(net.index(:,2:end), 2, 2));


fn_lattice_a1 = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_4.mat'));
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
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_lattice_a1.net.sys.pk_t, fn_lattice_a1.net.sys.pk_locs, fn_lattice_a1.net.sys.pops, 'order', idx);
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
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1_raster.epsc'));




fn_lattice_a2 = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_115.mat'));
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
saveas(gcf, fullfile(dout,'fn_lattice_traj_a2.epsc'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_lattice_a2.net.sys.pk_t, fn_lattice_a2.net.sys.pk_locs, fn_lattice_a2.net.sys.pops, 'order', idx);
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
saveas(gcf, fullfile(dout,'fn_lattice_traj_a2_raster.epsc'));
fn_lattice_a3 = load(fullfile('..', 'results_hypercube_attempt_fn_G_mid', 'out_3.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_lattice_a3.net.sys.t_mean, fn_lattice_a3.net.sys.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_lattice_a3.net.sys.t_mean, fn_lattice_a3.net.sys.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ko', 'filled');

c = (1-max([round(fn_lattice_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1.png'));
saveas(gcf, fullfile(dout,'fn_lattice_traj_a1.epsc'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_lattice_a3.net.sys.pk_t, fn_lattice_a3.net.sys.pk_locs, fn_lattice_a3.net.sys.pops, 'order', idx);
axis tight
xlim([0,500]);
xticks([0,500]);
xticklabels([0,500]);


c = (1-max([round(fn_lattice_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_traj_a3_raster.png'));
saveas(gcf, fullfile(dout,'fn_lattice_traj_a3_raster.epsc'));
%% FN Lattice
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_lattice_results.results.X_pred;
Y = fn_lattice_results.results.Y_pred;
Z = fn_lattice_results.results.pks_pred;
Z_ord = fn_lattice_results.results.ord_pred;

pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
scatter(fn_lattice_a1.assort, fn_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_lattice_a2.assort, fn_lattice_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_lattice_a3.assort, fn_lattice_a3.pvals(1), 200, 'ko', 'filled');
xticks([min(X(:)), max(X(:))]);

xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_peaks.png'));
saveas(gcf, fullfile(dout,'fn_lattice_peaks.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
pcolor(X,Y, Z_ord);
fun = @(x)(5*(x - 0.5));

contour(X,Y,Z_ord, [0.5, 0.5], 'color', [1, fun(0.5), 0], 'linewidth', 2);
contour(X,Y,Z_ord, [0.62, 0.62], 'color', [1, fun(0.62), 0], 'linewidth', 2);
contour(X,Y,Z_ord, [0.7, 0.7], 'color', [1, fun(0.7), 0], 'linewidth', 2);
colorbar('XTick', [0 1],'XTickLabel', [0 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
scatter(fn_lattice_a1.assort, fn_lattice_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_lattice_a2.assort, fn_lattice_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_lattice_a3.assort, fn_lattice_a3.pvals(1), 200, 'ko', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
axis tight;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_ord.png'));
saveas(gcf, fullfile(dout,'fn_lattice_ord.epsc'));


%% Trajectories FN Netgen

fn_netgen_a1 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a1.net.t_mean, fn_netgen_a1.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a1.net.t_mean, fn_netgen_a1.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ks', 'filled');

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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a1.net.pk_t, fn_netgen_a1.net.pk_locs, fn_netgen_a1.net.pops, 'order');
axis tight
xlim([0,500]);
xticks([0,500]);
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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1_raster.epsc'));




fn_netgen_a2 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_2.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a2.net.t_mean, fn_netgen_a2.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a2.net.t_mean, fn_netgen_a2.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'kd', 'filled');

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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a2.epsc'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a2.net.pk_t, fn_netgen_a2.net.pk_locs, fn_netgen_a2.net.pops, 'order');
axis tight
xlim([0,500]);
xticks([0,500]);
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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a2_raster.epsc'));
fn_netgen_a3 = load(fullfile('..', 'results_netgen_attempt_fn_G_mid', 'out_4.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a3.net.t_mean, fn_netgen_a3.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a3.net.t_mean, fn_netgen_a3.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ko', 'filled');

c = (1-max([round(fn_netgen_a3.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1.png'));
saveas(gcf, fullfile(dout,'fn_netgen_traj_a1.epsc'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a3.net.pk_t, fn_netgen_a3.net.pk_locs, fn_netgen_a3.net.pops, 'order');
axis tight
xlim([0,500]);
xticks([0,500]);
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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a3_raster.epsc'));


%% FN Netgen
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_netgen_results.results.X_pred;
Y = fn_netgen_results.results.Y_pred;
Z = fn_netgen_results.results.pks_pred;
Z_ord = fn_netgen_results.results.ord_pred;
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
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'ko', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_peaks.png'));
saveas(gcf, fullfile(dout,'fn_netgen_peaks.epsc'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
pcolor(X,Y,Z_ord);

fun = @(x)(5*(x - 0.5));

contour(X,Y,Z_ord, [0.5, 0.5], 'color', [1, fun(0.5), 0], 'linewidth', 2);
contour(X,Y,Z_ord, [0.62, 0.62], 'color', [1, fun(0.62), 0], 'linewidth', 2);
contour(X,Y,Z_ord, [0.7, 0.7], 'color', [1, fun(0.7), 0], 'linewidth', 2);
%contour(X,Y,Z_ord, [0.8, 0.8], 'color', [1, fun(0.8), 0], 'linewidth', 2);
colorbar('XTick', [0,1],'XTickLabel', [0, 1]);caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;
scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 200, 'ks', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 200, 'kd', 'filled');
scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 200, 'ko', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_order.png'));
saveas(gcf, fullfile(dout,'fn_netgen_order.epsc'));