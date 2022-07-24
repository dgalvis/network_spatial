%=========================================================================%
% Function: run_concat_single
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% Concatenate the peaks and order parameter results for run_model_single.m
% Greatly reduces the size of results for removing from HPC (since no
% rasters are included here).
% 
% Note: run_model_single.m must be run first!!!
%
% Parameters
% ==========
% name   : directory name
%============================

function run_concat_single(name)


    addpath('functions');
    config = run_setup_single_config(name, 0, 0);
    dout = ['results_single_', config.name];
    clear config;
    
    
    
    load(fullfile(dout,'parameters.mat'), 'config', 'assort_all');
    
    assort_concat = zeros(length(assort_all), config.num_pars);
    G_concat = zeros(length(assort_all), config.num_pars);
    gconn_concat = zeros(length(assort_all), config.num_pars);
    pks_concat = zeros(length(assort_all), config.num_pars);
    pks_p1_concat = zeros(length(assort_all), config.num_pars);
    pks_p2_concat = zeros(length(assort_all), config.num_pars);
    ord_concat = zeros(length(assort_all), config.num_pars);
    ord_p1_concat = zeros(length(assort_all), config.num_pars);
    ord_p2_concat = zeros(length(assort_all), config.num_pars);
    for i = 1:config.inc:length(assort_all)
        for j = 1:config.num_pars
            load(fullfile(dout, ['out_', num2str(i), '_', num2str(j),  '.mat']), 'net', 'pvals', 'assort');
            
            assort_concat(i,j) = assort;
            G_concat(i,j)      = pvals(1);
            gconn_concat(i,j)  = pvals(2);
            pks_concat(i,j)    = mean(sum(net.sys.pk_locs));
            pks_p1_concat(i,j)    = mean(sum(net.sys.pk_locs(:, logical(net.sys.pops))));
            pks_p2_concat(i,j)    = mean(sum(net.sys.pk_locs(:, ~logical(net.sys.pops))));
            ord_concat(i,j)    = net.sys.ord;
            ord_p1_concat(i,j)    = net.sys.ord_pops(2);
            ord_p2_concat(i,j)    = net.sys.ord_pops(1);
        end
    end
    clear i j net pvals assort config assort_all;
    save(fullfile(dout,'out_concat'), 'pks_concat', 'ord_concat', ...
        'pks_p1_concat', 'pks_p2_concat', 'ord_p1_concat', 'ord_p2_concat', ...
        'assort_concat', 'G_concat', 'gconn_concat');

end