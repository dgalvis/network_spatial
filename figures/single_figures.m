%% Initialise
clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
addpath(fullfile('..','functions_netgen'));

netgen_config = load(fullfile('..', 'results_single_netgen_attempt_fn_G_high', 'parameters.mat'));
lattice_config = load(fullfile('..', 'results_single_attempt_fn_G_high', 'parameters.mat'));

netgen_results = load(fullfile('..', 'results_single_netgen_attempt_fn_G_high', 'out_concat.mat'));
lattice_results = load(fullfile('..', 'results_single_attempt_fn_G_high', 'out_concat.mat'));


dout = 'single_figures';
%% Plot Structures (Lattice)
load(fullfile('..', 'results_single_attempt_fn_G_high', 'out_1_1.mat'), 'net');
locations = net.index(:,2:end);
%connections = net.conns;
pops_all = lattice_config.pops_all;
assort_all =  lattice_config.assort_all;


% Lattice Networks
h1 = figure('Renderer', 'painters', 'Position', [10, 10, 2000, 300]);
sort_idx = [1, 61, 121, 181, 240];
for i = 1:length(sort_idx)
    subplot(1, length(sort_idx), i);hold all;
    
    j = logical(pops_all(:, sort_idx(i)));
    scatter3(locations(j, 1), locations(j, 2), locations(j, 3), 50, 'b', 'filled');
    scatter3(locations(~j, 1), locations(~j, 2), locations(~j, 3), 10, 'k', 'filled');
    xticks({});
    yticks({});
    zticks({});
    view(35, 45);
    c = (1-max([round(assort_all(sort_idx(i)),2),0]));
    set(gca, 'color', [1,c,c]);
    title(['a = ',num2str(sort_idx(i)-1)]);
    H = gca;
    H.LineWidth = 2;
    H.FontSize = 16;
    H.FontWeight = 'bold';
    box on;
   
    
end
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'lattice.png'));

% Colorbar
hf = figure('Units','normalized'); 
ax = axes;
c = colorbar(ax, 'north');
map = [ones(1000,1), linspace(1,1-round(assort_all(sort_idx(end)),2),1000)', linspace(1,1-round(assort_all(sort_idx(end)),2),1000)'];
colormap(map)
ax.Visible = 'off';
c.Position = [0.15 0.3 0.74 0.4];
c.Ticks = [0,1];
c.TickLabels = {0,round(assort_all(sort_idx(end)),2)};
hf.Position(4) = 0.1000;
c.LineWidth = 2;
ax.FontSize = 16;
ax.FontWeight = 'bold';
saveas(gcf, fullfile(dout,'lattice_colorbar.png'));
%% Plot Structures (Netgen)
pops_all = netgen_config.pops_all;
assort_all =  netgen_config.assort_all;
connections = netgen_config.config.net_conns;
num_nodes = netgen_config.config.num_nodes;


% Watts-Strogatz Networks
figure('Renderer', 'painters', 'Position', [10, 10, 2000, 300]);
sort_idx = [1, 81, 151, 236, 315];

t = linspace(0, 2*pi, num_nodes+1);t = t(1:end-1);
x = sin(t);
y = cos(t);

for i = 1:length(sort_idx)
    subplot(1, length(sort_idx), i);hold all;
    
    p = logical(pops_all(:, sort_idx(i)));
    
    x = sin(t);
    y = cos(t);
    x(p) = 0.8*x(p);
    y(p) = 0.8*y(p);
    
    
%     for j = 1:num_nodes-1
%         for k = (j+1):num_nodes
%             if connections(j,k) > 0
%                 if p(j) == p(k)
%                     if p(j) == 0
%                         plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.2, 'color', 0.8*ones(3,1));
%                     end
%                 end
%             end
%         end
%     end   
    for j = 1:num_nodes-1
        for k = (j+1):num_nodes
            if connections(j,k) > 0
                if p(j) ~= p(k)
                   plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.5, 'color', 'k');
                end
            end
        end
    end
    for j = 1:num_nodes-1
        for k = (j+1):num_nodes
            if connections(j,k) > 0
                if p(j) == p(k)
                    if p(j) > 0
                        plot([x(j), x(k)], [y(j), y(k)], 'linewidth',1, 'color', 'b');
                    end
                end
            end
        end
    end
    
    
    scatter(x(~p), y(~p), 10, 'k', 'filled');
    scatter(x(p), y(p), 50, 'b', 'filled');
    
    xticks({});
    yticks({});
    zticks({});
    axis([-1.1, 1.1, -1.1, 1.1]);

    c = (1-max([round(assort_all(sort_idx(i)),2),0]));
    set(gca, 'color', [1,c,c]);
    title(['a = ',num2str(sort_idx(i)-1)]);
    H = gca;
    H.LineWidth = 2;
    H.FontSize = 16;
    H.FontWeight = 'bold';
    box on;
        
end
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'netgen.png'));
% Colorbar
hf = figure('Units','normalized'); 
ax = axes;
c = colorbar(ax, 'north');
map = [ones(1000,1), linspace(1,1-round(assort_all(sort_idx(end)),2),1000)', linspace(1,1-round(assort_all(sort_idx(end)),2),1000)'];
colormap(map)
ax.Visible = 'off';
c.Position = [0.15 0.3 0.74 0.4];
c.Ticks = [0,1];
c.TickLabels = {0,round(assort_all(sort_idx(end)),2)};
hf.Position(4) = 0.1000;
c.LineWidth = 2;
ax.FontSize = 16;
ax.FontWeight = 'bold';
saveas(gcf, fullfile(dout,'netgen_colorbar.png'));

% Insets
% Watts-Strogatz Networks
sort_idx = [1, 315];

t = linspace(0, 2*pi, num_nodes+1);t = t(1:end-1);
x = sin(t);
y = cos(t);

for i = 1:length(sort_idx)
    figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
    
    p = logical(pops_all(:, sort_idx(i)));
    
    x = sin(t);
    y = cos(t);
    x(p) = 0.8*x(p);
    y(p) = 0.8*y(p);
    
    
%     for j = 1:num_nodes-1
%         for k = (j+1):num_nodes
%             if connections(j,k) > 0
%                 if p(j) == p(k)
%                     if p(j) == 0
%                         plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.2, 'color', 0.8*ones(3,1));
%                     end
%                 end
%             end
%         end
%     end   
    for j = 1:num_nodes-1
        for k = (j+1):num_nodes
            if connections(j,k) > 0
                if p(j) ~= p(k)
                   plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.5, 'color', 'k');
                end
            end
        end
    end
    for j = 1:num_nodes-1
        for k = (j+1):num_nodes
            if connections(j,k) > 0
                if p(j) == p(k)
                    if p(j) > 0
                        plot([x(j), x(k)], [y(j), y(k)], 'linewidth',1, 'color', 'b');
                    end
                end
            end
        end
    end
    
    
    scatter(x(~p), y(~p), 20, 'k', 'filled');
    scatter(x(p), y(p), 50, 'b', 'filled');
    
    xticks({});
    yticks({});
    zticks({});
    axis([0.5, 1.1, -0.255, 0.255]);

    c = (1-max([round(assort_all(sort_idx(i)),2),0]));
    set(gca, 'color', [1,c,c]);
    title(['a = ',num2str(sort_idx(i)-1)]);
    H = gca;
    H.LineWidth = 2;
    H.FontSize = 16;
    H.FontWeight = 'bold';
    box on;
    saveas(gcf, fullfile(dout,['netgen_inset_', num2str(sort_idx(i)),'.png']));    
end

%% Heatmaps (Lattice)
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
surf(lattice_results.assort_concat, lattice_results.G_concat, lattice_results.pks_concat);
shading('flat');
axis tight;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on
saveas(gcf, fullfile(dout,'lattice_heatmap.png'));
%% Heatmaps (WS)
figure('Renderer', 'painters', 'Position', [10, 10, 500, 500]);hold all;
surf(netgen_results.assort_concat, netgen_results.G_concat, netgen_results.pks_concat);
shading('flat');
axis tight;
H = gca;
H.LineWidth = 2;
H.FontSize = 16;
H.FontWeight = 'bold';
box on
saveas(gcf, fullfile(dout,'netgen_heatmap.png'));
%% Trajectories (Lattice)

figure('Renderer', 'painters', 'Position', [10, 10, 2000, 300]);
sort_idx = [1, 61, 121, 181, 240];
for i = 1:length(sort_idx)
    
    load(fullfile('..', 'results_single_attempt_fn_G_high', ['out_',num2str(sort_idx(i)),'_11.mat']), 'net');
    subplot(1, length(sort_idx), i);hold all;
    
    plot(net.sys.t_mean, net.sys.y_pops(:,1),'k', 'linewidth', 2);
    plot(net.sys.t_mean, net.sys.y_pops(:,2),'b', 'linewidth', 2);
    axis([0,500, -3, 3]);
    c = (1-max([round(assort_all(sort_idx(i)),2),0]));
    set(gca, 'color', [1,c,c]);
    title(['a = ',num2str(sort_idx(i)-1)]);
    H = gca;
    H.LineWidth = 2;
    H.FontSize = 16;
    H.FontWeight = 'bold';
    box on;
    
end
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'lattice_traj.png'));
%% Trajectories (WS)
figure('Renderer', 'painters', 'Position', [10, 10, 2000, 300]);
sort_idx = [1, 81, 151, 236, 315];
for i = 1:length(sort_idx)
    
    load(fullfile('..', 'results_single_netgen_attempt_fn_G_high', ['out_',num2str(sort_idx(i)),'_11.mat']), 'net');
    subplot(1, length(sort_idx), i);hold all;
    
    plot(net.t_mean, net.y_pops(:,1),'k', 'linewidth', 2);
    plot(net.t_mean, net.y_pops(:,2),'b', 'linewidth', 2);
    axis([0,500, -3, 3]);
    c = (1-max([round(assort_all(sort_idx(i)),2),0]));
    set(gca, 'color', [1,c,c]);
    title(['a = ',num2str(sort_idx(i)-1)]);
    H = gca;
    H.LineWidth = 2;
    H.FontSize = 16;
    H.FontWeight = 'bold';
    box on;
    
end
set(gcf, 'color', [1,1,1]);
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf, fullfile(dout,'netgen_traj.png'));