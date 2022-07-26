%% Initialise
clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
addpath(fullfile('..','functions_netgen'));

fn_netgen_config = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn', 'cube.mat'));
fn_netgen_p0_config = load(fullfile( '..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'cube.mat'));
fn_hypercube_config = load(fullfile('..', 'results_hypercube_attempt_fn_G_and_gconn', 'cube.mat'));

fn_netgen_results = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn', 'out_gp.mat'));
fn_netgen_p0_results = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_gp.mat'));
fn_hypercube_results = load(fullfile('..', 'results_hypercube_attempt_fn_G_and_gconn', 'out_gp.mat'));

dout = 'G_and_gconn_figures';



%% FN Netgen Peaks
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_netgen_results.results.X_pred;
Y1 = fn_netgen_results.results.Y1_pred;
Y2 = fn_netgen_results.results.Y2_pred;
Z = fn_netgen_results.results.pks_pred;
Z_p1 = fn_netgen_results.results.pks_p1_pred;
Z_p2 = fn_netgen_results.results.pks_p2_pred;

Z_ord = fn_netgen_results.results.ord_pred;
Z_ord_p1 = fn_netgen_results.results.ord_p1_pred;
Z_ord_p2 = fn_netgen_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.6;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.6;
%colorbar('XTick', [0,1],'XTickLabel',[0,1]); caxis([0, 1]);
view([135, 10]);
%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_netgen_peaks.png'));
exportgraphics(gcf, fullfile(dout,'fn_netgen_peaks.png'), 'Resolution', 600);

%% FN Netgen Order
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_netgen_results.results.X_pred;
Y1 = fn_netgen_results.results.Y1_pred;
Y2 = fn_netgen_results.results.Y2_pred;
Z = fn_netgen_results.results.pks_pred;
Z_p1 = fn_netgen_results.results.pks_p1_pred;
Z_p2 = fn_netgen_results.results.pks_p2_pred;

Z_ord = fn_netgen_results.results.ord_pred;
Z_ord_p1 = fn_netgen_results.results.ord_p1_pred;
Z_ord_p2 = fn_netgen_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.1;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.1;

h2 = patch(isosurface(X, Y1, Y2, Z_ord, 0.5, 0.5*ones(size(Z))));
h2.EdgeColor = 'none';
h2.FaceColor = 'interp';
h2.FaceAlpha = 0.7;
h3 = patch(isosurface(X, Y1, Y2, Z_ord, 0.62, 0.62*ones(size(Z))));
h3.EdgeColor = 'none';
h3.FaceColor = 'interp';
h3.FaceAlpha = 0.7;
h4 = patch(isosurface(X, Y1, Y2, Z_ord, 0.7, 0.7*ones(size(Z))));
h4.EdgeColor = 'none';
h4.FaceColor = 'interp';
h4.FaceAlpha = 0.7;

% h2 = patch(isosurface(X, Y1, Y2, Z_ord, 0.38, 0.38*ones(size(Z))));
% h2.EdgeColor = 'none';
% h2.FaceColor = 'interp';
% h2.FaceAlpha = 0.7;

%colorbar('XTick', [0.5,0.7],'XTickLabel',[0.5,0.7], 'Location','northoutside'); 
caxis([0.5, 0.7]);


%alpha  0.6;
%shading interp
colormap('autumn');
view([135, 10]);

%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_netgen_order.png'));
exportgraphics(gcf, fullfile(dout,'fn_netgen_order.png'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'fn_netgen_order.epsc'));

%% FN Netgen Peaks P0
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_netgen_p0_results.results.X_pred;
Y1 = fn_netgen_p0_results.results.Y1_pred;
Y2 = fn_netgen_p0_results.results.Y2_pred;
Z = fn_netgen_p0_results.results.pks_pred;
Z_p1 = fn_netgen_p0_results.results.pks_p1_pred;
Z_p2 = fn_netgen_p0_results.results.pks_p2_pred;

Z_ord = fn_netgen_p0_results.results.ord_pred;
Z_ord_p1 = fn_netgen_p0_results.results.ord_p1_pred;
Z_ord_p2 = fn_netgen_p0_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.6;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.6;
%colorbar('XTick', [0,1],'XTickLabel',[0,1]); caxis([0, 1]);
view([135, 10]);
%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_netgen_p0_peaks.png'));
exportgraphics(gcf, fullfile(dout,'fn_netgen_p0_peaks.png'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'fn_netgen_p0_peaks.epsc'));


%% FN Netgen Order P0
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_netgen_p0_results.results.X_pred;
Y1 = fn_netgen_p0_results.results.Y1_pred;
Y2 = fn_netgen_p0_results.results.Y2_pred;
Z = fn_netgen_p0_results.results.pks_pred;
Z_p1 = fn_netgen_p0_results.results.pks_p1_pred;
Z_p2 = fn_netgen_p0_results.results.pks_p2_pred;

Z_ord = fn_netgen_p0_results.results.ord_pred;
Z_ord_p1 = fn_netgen_p0_results.results.ord_p1_pred;
Z_ord_p2 = fn_netgen_p0_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.1;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.1;

h2 = patch(isosurface(X, Y1, Y2, Z_ord, 0.5, 0.5*ones(size(Z))));
h2.EdgeColor = 'none';
h2.FaceColor = 'interp';
h2.FaceAlpha = 0.7;
h3 = patch(isosurface(X, Y1, Y2, Z_ord, 0.62, 0.62*ones(size(Z))));
h3.EdgeColor = 'none';
h3.FaceColor = 'interp';
h3.FaceAlpha = 0.7;
h4 = patch(isosurface(X, Y1, Y2, Z_ord, 0.7, 0.7*ones(size(Z))));
h4.EdgeColor = 'none';
h4.FaceColor = 'interp';
h4.FaceAlpha = 0.7;



%colorbar('XTick', [0.5,0.7],'XTickLabel',[0.5,0.7], 'Location','northoutside'); 
caxis([0.5, 0.7]);


%alpha  0.6;
%shading interp
colormap('autumn');
view([135, 10]);

%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_netgen_p0_order.png'));
exportgraphics(gcf, fullfile(dout,'fn_netgen_p0_order.png'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'fn_netgen_p0_order.epsc'));

%% FN Hypercube Peaks
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_hypercube_results.results.X_pred;
Y1 = fn_hypercube_results.results.Y1_pred;
Y2 = fn_hypercube_results.results.Y2_pred;
Z = fn_hypercube_results.results.pks_pred;
Z_p1 = fn_hypercube_results.results.pks_p1_pred;
Z_p2 = fn_hypercube_results.results.pks_p2_pred;

Z_ord = fn_hypercube_results.results.ord_pred;
Z_ord_p1 = fn_hypercube_results.results.ord_p1_pred;
Z_ord_p2 = fn_hypercube_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.6;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.6;
%alpha  0.6;
%shading interp;
%colorbar('XTick', [0,1],'XTickLabel',[0,1]); caxis([0, 1]);
view([110, 10]);
%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_hypercube_peaks.png'));
exportgraphics(gcf, fullfile(dout,'fn_hypercube_peaks.png'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'fn_hypercube_peaks.epsc'));
           %% FN Hypercube ORDER
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_hypercube_results.results.X_pred;
Y1 = fn_hypercube_results.results.Y1_pred;
Y2 = fn_hypercube_results.results.Y2_pred;
Z = fn_hypercube_results.results.pks_pred;
Z_p1 = fn_hypercube_results.results.pks_p1_pred;
Z_p2 = fn_hypercube_results.results.pks_p2_pred;

Z_ord = fn_hypercube_results.results.ord_pred;
Z_ord_p1 = fn_hypercube_results.results.ord_p1_pred;
Z_ord_p2 = fn_hypercube_results.results.ord_p2_pred;

h1 = patch(isosurface(X, Y1, Y2, Z_p1, 0.5*max(Z_p1(:)), Y2));
h1.EdgeColor = 'none';
h1.FaceColor = [0,0,1];
h1.FaceAlpha = 0.1;

h1b = patch(isosurface(X, Y1, Y2, Z_p2, 0.65*max(Z_p2(:)), Y2));
h1b.EdgeColor = 'none';
h1b.FaceColor = [0,0,0];
h1b.FaceAlpha = 0.1;




h2 = patch(isosurface(X, Y1, Y2, Z_ord, 0.5, 0.5*ones(size(Z))));
h2.EdgeColor = 'none';
h2.FaceColor = 'interp';
h2.FaceAlpha = 0.7;
h3 = patch(isosurface(X, Y1, Y2, Z_ord, 0.62, 0.62*ones(size(Z))));
h3.EdgeColor = 'none';
h3.FaceColor = 'interp';
h3.FaceAlpha = 0.7;
h4 = patch(isosurface(X, Y1, Y2, Z_ord, 0.7, 0.7*ones(size(Z))));
h4.EdgeColor = 'none';
h4.FaceColor = 'interp';
h4.FaceAlpha = 0.7;
%colorbar('XTick', [0.5,0.7],'XTickLabel',[0.5,0.7], 'Location','northoutside'); 
caxis([0.5, 0.7]);
view([110, 10])
%alpha(0.6);
%shading interp
colormap('autumn')

%xlabel('sort');
%ylabel('gconn');
%zlabel('G');
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box off;

xticks(linspace(min(X(:)), max(X(:)), 5));
xticklabels(round(linspace(min(X(:)), max(X(:)), 5),2));
yticks(linspace(min(Y1(:)), max(Y1(:)),5));
yticklabels(round(linspace(min(Y1(:)), max(Y1(:)),5),2));
zticks(linspace(min(Y2(:)), max(Y2(:)),5));
zticklabels(round(linspace(min(Y2(:)), max(Y2(:)),5),2));
axis([min(X(:)),max(X(:)), min(Y1(:)),max(Y1(:)), min(Y2(:)),max(Y2(:))]);
grid on;
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
%saveas(gcf, fullfile(dout,'fn_hypercube_order.png'));
exportgraphics(gcf, fullfile(dout,'fn_hypercube_order.png'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'fn_hypercube_order.epsc'));


%% Colorbar
hf = figure('Units','normalized'); 
ax = axes;
c = colorbar(ax, 'north');
colormap('autumn')
ax.Visible = 'off';
c.Position = [0.15 0.3 0.74 0.4];
c.Ticks = [0.5,0.7];
c.TickLabels = {0.5, 0.7};
caxis([0.5,0.7]);
hf.Position(4) = 0.1000;
c.LineWidth = 2;
ax.FontSize = 20;
ax.FontWeight = 'bold';
%saveas(gcf, fullfile(dout,'colorbar.png'));
exportgraphics(gcf, fullfile(dout,'colorbar.eps'), 'Resolution', 600);
%saveas(gcf, fullfile(dout,'lattice_colorbar.epsc'));