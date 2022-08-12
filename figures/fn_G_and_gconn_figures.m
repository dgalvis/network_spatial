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

dout = 'fn_G_and_gconn_figures';



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


%% Slice Traj

fn_netgen_a1 = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_161.mat'));
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

fn_netgen_a2 = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_105.mat'));
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


fn_netgen_a3 = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_6301.mat'));
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

fn_netgen_a4 = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_2534.mat'));
figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
make_raster(fn_netgen_a4.net.pk_t, fn_netgen_a4.net.pk_locs, fn_netgen_a4.net.pops, 'order');
axis tight
xlim([0,500]);
xticks([0,500]);
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
saveas(gcf, fullfile(dout,'fn_netgen_traj_a4_raster.epsc'));


% r = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', 'out_concat.mat'));
% x = find(r.gconn_concat > 0.099  & r.G_concat < 0.2 & r.assort_concat > 0.7)';
% %x = find(r.gconn_concat < 0.021)';
% for i = x
%     
%     fn_netgen_a4 = load(fullfile('..', 'results_netgen_attempt_fn_G_and_gconn_p0', ['out_', num2str(i),'.mat']));
%     figure('Renderer', 'painters', 'Position', [10, 10, 500, 300]);hold all;
%     make_raster(fn_netgen_a4.net.pk_t, fn_netgen_a4.net.pk_locs, fn_netgen_a4.net.pops, 'order');
%     axis tight
%     xlim([0,500]);
%     xticks([0,500]);
%     xticklabels([0,500]);
% 
% 
%     c = (1-max([round(fn_netgen_a4.assort,2),0]));
%     set(gca, 'color', [1,c,c]);
%     H = gca;
%     H.LineWidth = 2;
%     H.FontSize = 16;
%     H.FontWeight = 'bold';
%     box on;
%     
%     title(num2str(i));
%     pause;
%     
% end



%%  FN Netgen Peaks P0 (slice 1)
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500], 'Units', 'points');hold all;
X = fn_netgen_p0_results.results.X_pred;
Y1 = fn_netgen_p0_results.results.Y1_pred;
Y2 = fn_netgen_p0_results.results.Y2_pred;
Z = fn_netgen_p0_results.results.pks_pred;
Z_ord = fn_netgen_p0_results.results.ord_pred;


X = squeeze(X(end, :, :));
Y1 = squeeze(Y1(end,:, :));
Y2 = squeeze(Y2(end,:, :));
Z = squeeze(Z(end,:, :));
Z_ord = squeeze(Z_ord(end,:, :));


subplot(221);hold all;
pcolor(X, Y2, Z);
shading interp;
axis tight;
contour(X,Y2,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2] , 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 12;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 100, 'ks', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 100, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y2(:)), max(Y2(:))]);
yticklabels([round(min(Y2(:)),2), round(max(Y2(:)),2)]);

subplot(222);hold all;
pcolor(X, Y2, Z_ord);
shading interp;
axis tight;
contour(X,Y2,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);
caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 12;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_a3.assort, fn_netgen_a3.pvals(1), 100, 'ks', 'filled');
scatter(fn_netgen_a4.assort, fn_netgen_a4.pvals(1), 100, 'kd', 'filled');

xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y2(:)), max(Y2(:))]);
yticklabels([round(min(Y2(:)),2), round(max(Y2(:)),2)]);

X = fn_netgen_p0_results.results.X_pred;
Y1 = fn_netgen_p0_results.results.Y1_pred;
Y2 = fn_netgen_p0_results.results.Y2_pred;
Z = fn_netgen_p0_results.results.pks_pred;
Z_ord = fn_netgen_p0_results.results.ord_pred;

X = squeeze(X(1, :, :));
Y1 = squeeze(Y1(1,:, :));
Y2 = squeeze(Y2(1,:, :));
Z = squeeze(Z(1,:, :));
Z_ord = squeeze(Z_ord(1,:, :));

subplot(223);hold all;
pcolor(X, Y2, Z);
shading interp;
axis tight;
contour(X,Y2,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2] , 'k', 'linewidth', 2);
colorbar('XTick', [min(Z(:)), max(Z(:))],'XTickLabel', [0, round(max(Z(:)))]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 12;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 100, 'ko', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 100, 'k^', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y2(:)), max(Y2(:))]);
yticklabels([round(min(Y2(:)),2), round(max(Y2(:)),2)]);

subplot(224);hold all;
pcolor(X, Y2, Z_ord);
shading interp;
axis tight;
contour(X,Y2,Z, [ (max(Z(:))+min(Z(:)))/2,  (max(Z(:))+min(Z(:)))/2], 'k', 'linewidth', 2);
colorbar('XTick', [0, 1],'XTickLabel', [0, 1]);
caxis([0,1]);
shading interp;
H = gca;
H.LineWidth = 2;
H.FontSize = 12;
H.FontWeight = 'bold';
box on;

scatter(fn_netgen_a1.assort, fn_netgen_a1.pvals(1), 100, 'ko', 'filled');
scatter(fn_netgen_a2.assort, fn_netgen_a2.pvals(1), 100, 'k^', 'filled');
xticks([min(X(:)), max(X(:))]);
xticklabels([round(min(X(:)),2), round(max(X(:)),2)]);
yticks([min(Y2(:)), max(Y2(:))]);
yticklabels([round(min(Y2(:)),2), round(max(Y2(:)),2)]);

saveas(gcf, fullfile(dout,'fn_netgen_p0_slices.epsc'));

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