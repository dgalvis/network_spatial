%% Initialise
clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
addpath(fullfile('..','functions_netgen'));

fn_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_G_high', 'cube.mat'));
fn_lattice_config = load(fullfile('..', 'results_hypercube_attempt_fn_G_high', 'cube.mat'));
srk_netgen_config = load(fullfile('..', 'results_netgen_attempt_srk_G_high_longT', 'cube.mat'));
srk_lattice_config = load(fullfile('..', 'results_hypercube_attempt_srk_G_high_longT', 'cube.mat'));

fn_low_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_G_high_beta_low', 'cube.mat'));
fn_high_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_G_high_beta_high', 'cube.mat'));


fn_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_G_high', 'out_gp.mat'));
fn_lattice_results = load(fullfile('..', 'results_hypercube_attempt_fn_G_high', 'out_gp.mat'));
srk_netgen_results = load(fullfile('..', 'results_netgen_attempt_srk_G_high_longT', 'out_gp.mat'));
srk_lattice_results = load(fullfile('..', 'results_hypercube_attempt_srk_G_high_longT', 'out_gp.mat'));

fn_low_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_G_high_beta_low', 'out_gp.mat'));
fn_high_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_G_high_beta_high', 'out_gp.mat'));
dout = 'strong_figures';

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
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice.epsc'));

%% SRK Lattice
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_lattice_results.results.X_pred;
Y = srk_lattice_results.results.Y_pred;
Z = srk_lattice_results.results.pks_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0, round(max(Z(:)))],'XTickLabel', [0, round(max(Z(:)))]);
caxis([0, round(max(Z(:)))])
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice.epsc'));
%% Trajectories FN Netgen
fn_netgen_q = load(fullfile('..', 'results_netgen_attempt_fn_G_high', 'out_1.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_q.net.t_mean, fn_netgen_q.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_q.net.t_mean, fn_netgen_q.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ko', 'filled');

c = (1-max([round(fn_netgen_q.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_q.epsc'));


fn_netgen_a = load(fullfile('..', 'results_netgen_attempt_fn_G_high', 'out_7.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(fn_netgen_a.net.t_mean, fn_netgen_a.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(fn_netgen_a.net.t_mean, fn_netgen_a.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 500, -3, 3]);
xticks([0,500]);
xticklabels([0,500]);
yticks([-3,3]);
yticklabels([-3,3]);

scatter(20, 2.4, 150,'ks', 'filled');

c = (1-max([round(fn_netgen_a.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a.net.pk_t, fn_netgen_a.net.pk_locs, fn_netgen_a.net.pops);
axis tight
xlim([0,500]);
xticks([0,500]);
xticklabels([0,500]);


c = (1-max([round(fn_netgen_a.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_traj_a_raster.epsc'));

%% FN WS
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_netgen_results.results.X_pred;
Y = fn_netgen_results.results.Y_pred;
Z = fn_netgen_results.results.pks_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);

scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(fn_netgen_a.assort, fn_netgen_a.pvals(1), 200, 'ks', 'filled');

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen.epsc'));

%% FN WS Without some stuff
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_netgen_results.results.X_pred;
Y = fn_netgen_results.results.Y_pred;
Z = fn_netgen_results.results.pks_pred;
pcolor(X,Y,Z);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
axis tight;

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_naked.epsc'));

%% Trajectories SRK netgen
srk_netgen_q = load(fullfile('..', 'results_netgen_attempt_srk_G_high', 'out_2.mat'));
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
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_q.epsc'));

srk_netgen_a = load(fullfile('..', 'results_netgen_attempt_srk_G_high', 'out_8.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
plot(srk_netgen_a.net.t_mean/60000, srk_netgen_a.net.y_pops(:,1), 'k', 'linewidth', 2);
plot(srk_netgen_a.net.t_mean/60000, srk_netgen_a.net.y_pops(:,2), 'b', 'linewidth', 2);
axis([0, 5, 0, 1]);
xticks([0,5]);
xticklabels([0,5]);
yticks([0,1]);
yticklabels([0,1]);

scatter(0.2, 0.9, 150,'ks', 'filled');

c = (1-max([round(srk_netgen_a.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(srk_netgen_a.net.pk_t/60000, srk_netgen_a.net.pk_locs, srk_netgen_a.net.pops);
axis tight
xlim([0,5]);
xticks([0,5]);
xticklabels([0,5]);


c = (1-max([round(srk_netgen_a.assort,2),0]));
set(gca, 'color', [1,c,c]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen_traj_a_raster.epsc'));


%% SRK Netgen
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_netgen_results.results.X_pred;
Y = srk_netgen_results.results.Y_pred;
Z = srk_netgen_results.results.pks_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0, round(max(Z(:)))],'XTickLabel', [0, round(max(Z(:)))]);
caxis([0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);

scatter(srk_netgen_q.assort, srk_netgen_q.pvals(1), 200, 'ko', 'filled');
scatter(srk_netgen_a.assort, srk_netgen_a.pvals(1), 200, 'ks', 'filled');

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen.epsc'));
%% Fn Netgen Data
r = load(fullfile('..', 'results_netgen_attempt_fn_G_high', 'out_concat.mat'));
X = fn_netgen_results.results.X_pred;
Y = fn_netgen_results.results.Y_pred;
Z = fn_netgen_results.results.pks_pred;

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
scatter3(r.assort_concat, r.G_concat, r.pks_concat, 'k', 'filled');
view([60, 15]);
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
zticks([0, max(Z(:))]);
zticklabels([0, round(max(Z(:)))]);
box on;
axis([min(X(:)), max(X(:)), min(Y(:)), max(Y(:)), min(Z(:)), max(Z(:))]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_scatter.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;

scatter3(X(1:10:end),Y(1:10:end),Z(1:10:end), 'k', 'filled');
view([60, 15]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
zticks([0, max(Z(:))]);
zticklabels([0, round(max(Z(:)))]);
axis([min(X(:)), max(X(:)), min(Y(:)), max(Y(:)), min(Z(:)), max(Z(:))]);

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_gp_scatter.epsc'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
surf(X,Y,Z);
view([60, 15]);

shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
zticks([0, max(Z(:))]);
zticklabels([0, round(max(Z(:)))]);
axis([min(X(:)), max(X(:)), min(Y(:)), max(Y(:)), min(Z(:)), max(Z(:))]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_gp_surf.png'));
saveas(gcf, fullfile(dout,'fn_netgen_gp_surf.epsc'));
%% FN WS beta
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X1 = fn_netgen_results.results.X_pred;
Y1 = fn_netgen_results.results.Y_pred;
Z1 = fn_netgen_results.results.pks_pred;
contour(X1,Y1,Z1, [ (max(Z1(:))+min(Z1(:)))/2,  (max(Z1(:))+min(Z1(:)))/2], 'k', 'linewidth', 2);

X2 = fn_high_netgen_results.results.X_pred;
Y2 = fn_high_netgen_results.results.Y_pred;
Z2 = fn_high_netgen_results.results.pks_pred;
contour(X2,Y2,Z2, [ (max(Z2(:))+min(Z2(:)))/2,  (max(Z2(:))+min(Z2(:)))/2], 'r', 'linewidth', 2);

X3 = fn_low_netgen_results.results.X_pred;
Y3 = fn_low_netgen_results.results.Y_pred;
Z3 = fn_low_netgen_results.results.pks_pred;
contour(X3,Y3,Z3, [ (max(Z3(:))+min(Z3(:)))/2,  (max(Z3(:))+min(Z3(:)))/2], 'b', 'linewidth', 2);

H = gca;
H.LineWidth = 2;
H.FontSize = 20;
H.FontWeight = 'bold';
box on;

xticks([min(X1(:)), max(X3(:))]);
xticklabels([round(min(X1(:)),2), round(max(X3(:)),2)]);
yticks([min(Y1(:)), max(Y1(:))]);
yticklabels([round(min(Y1(:)),2), round(max(Y1(:)),2)]);

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen_rewire.epsc'));

%% FN WS beta order
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X1 = fn_netgen_results.results.X_pred;
Y1 = fn_netgen_results.results.Y_pred;
Z1 = fn_netgen_results.results.pks_pred;
pcolor(X1,Y1,Z1);
colorbar;
shading interp;
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X2 = fn_high_netgen_results.results.X_pred;
Y2 = fn_high_netgen_results.results.Y_pred;
Z2 = fn_high_netgen_results.results.pks_pred;
pcolor(X2,Y2,Z2);
colorbar;
shading interp;
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X3 = fn_low_netgen_results.results.X_pred;
Y3 = fn_low_netgen_results.results.Y_pred;
Z3 = fn_low_netgen_results.results.pks_pred;
pcolor(X3,Y3,Z3);
colorbar;
shading interp;



