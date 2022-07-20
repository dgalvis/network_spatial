%%
clear;clc;restoredefaultpath;close all;
addpath('../functions');
addpath('../functions_netgen');
load(fullfile('..','results_assort_netgen_forward_WS_locglo_p2', 'swap_01.mat'));

%test_id = 4;
%assort = assort{test_id};
%pops = pops{test_id};
%connections = conns{test_id};

% load(fullfile('results_single_netgen_attempt_fn_G_high', 'parameters.mat'));
% assort = assort_all;
% pops = pops_all;
% connections = config.net_conns;


t = linspace(0, 2*pi, config.num_nodes+1);t = t(1:end-1);

%%
figure();
for i =1:length(assort)
    clf;hold all;
    p = logical(pops(:, i));
    
    x = sin(t);
    y = cos(t);
    x(p) = 0.8*x(p);
    y(p) = 0.8*y(p);
    for j = 1:config.num_nodes-1
        for k = (j+1):config.num_nodes 
            if connections(j,k) > 0
                if p(j) == p(k)
                    if p(j) == 0
                        plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.2, 'color', 0.8*ones(3,1));
                    end
                end
            end
        end
    end   
    for j = 1:config.num_nodes-1
        for k = (j+1):config.num_nodes 
            if connections(j,k) > 0
                if p(j) ~= p(k)
                   plot([x(j), x(k)], [y(j), y(k)], 'linewidth', 0.5, 'color', 'k');
                end
            end
        end
    end
    for j = 1:config.num_nodes-1
        for k = (j+1):config.num_nodes 
            if connections(j,k) > 0
                if p(j) == p(k)
                    if p(j) > 0
                        plot([x(j), x(k)], [y(j), y(k)], 'linewidth',1, 'color', 'b');
                    end
                end
            end
        end
    end
    
    
    scatter(x(~p), y(~p), 100, 'k', 'filled');
    scatter(x(p), y(p), 100, 'b', 'filled');
    
    pause(0.1);
end