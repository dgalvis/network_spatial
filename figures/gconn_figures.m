%% Initialise
clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
addpath(fullfile('..','functions_netgen'));

fn_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_gconn', 'cube.mat'));
fn_lattice_config = load(fullfile('..', 'results_hypercube_attempt_fn_gconn', 'cube.mat'));
srk_netgen_config = load(fullfile('..', 'results_netgen_attempt_srk_gconn', 'cube.mat'));
srk_lattice_config = load(fullfile('..', 'results_hypercube_attempt_srk_gconn', 'cube.mat'));

fn_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_gconn', 'out_gp.mat'));
fn_lattice_results = load(fullfile('..', 'results_hypercube_attempt_fn_gconn', 'out_gp.mat'));
srk_netgen_results = load(fullfile('..', 'results_netgen_attempt_srk_gconn', 'out_gp.mat'));
srk_lattice_results = load(fullfile('..', 'results_hypercube_attempt_srk_gconn', 'out_gp.mat'));

dout = 'gconn_figures';

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

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = fn_lattice_results.results.X_pred;
Y = fn_lattice_results.results.Y_pred;
Z = fn_lattice_results.results.pks_p1_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_p1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;

Z = fn_lattice_results.results.ord_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_order.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;

Z = fn_lattice_results.results.ord_p1_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

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
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_lattice_order_p2.png'));

%% SRK Lattice
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_lattice_results.results.X_pred;
Y = srk_lattice_results.results.Y_pred;
Z = srk_lattice_results.results.pks_pred;
Zp1 = srk_lattice_results.results.pks_p1_pred;
Zp2 = srk_lattice_results.results.pks_p2_pred;
%pcolor(X,Y,Z);
%contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);
%contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);

pcolor(X,Y,Z);
%contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
contour(X,Y,Z, [6, 6], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;

Z = srk_lattice_results.results.ord_p1_pred;


pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_order_p1.png'));




figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;


pcolor(X,Y,Zp1);
contour(X,Y,Zp1, [ (max(Zp1(:))+min(Zp1(:)))/2,  (max(Zp1(:))+min(Zp1(:)))/2], 'b', 'linewidth', 2);

colorbar('XTick', [min(Zp1(:)), max(Zp1(:))],'XTickLabel', [0, round(max(Zp1(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_p1.png'));

figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;


pcolor(X,Y,Zp2);
contour(X,Y,Zp2, [ (max(Zp2(:))+min(Zp2(:)))/2,  (max(Zp2(:))+min(Zp2(:)))/2], 'k', 'linewidth', 2);

colorbar('XTick', [min(Zp2(:)), max(Zp2(:))],'XTickLabel', [0, round(max(Zp2(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_lattice_p2.png'));

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
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);

%scatter(fn_netgen_q.assort, fn_netgen_q.pvals(1), 200, 'ko', 'filled');
%scatter(fn_netgen_a.assort, fn_netgen_a.pvals(1), 200, 'ks', 'filled');

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'fn_netgen.png'));

%% SRK Netgen
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
X = srk_netgen_results.results.X_pred;
Y = srk_netgen_results.results.Y_pred;
Z = srk_netgen_results.results.pks_pred;
pcolor(X,Y,Z);
contour(X,Y,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on;

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y(:)), max(Y(:))]);
yticklabels([round(min(Y(:)),2), round(max(Y(:)),2)]);

%scatter(srk_netgen_q.assort, srk_netgen_q.pvals(1), 200, 'ko', 'filled');
%scatter(srk_netgen_a.assort, srk_netgen_a.pvals(1), 200, 'ks', 'filled');

set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'srk_netgen.png'));