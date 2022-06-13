%=========================================================================%
% Function: run_concat_netgen
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% Concatenate the peaks and order parameter results for run_model_netgen.m
% Greatly reduces the size of results for removing from HPC (since no
% rasters are included here).
% 
% Note: run_model_netgen.m must be run first!!!
%
% Parameters
% ==========
% name   : directory name
%============================

function run_concat_netgen(name)


    addpath('functions');
    config = run_setup_hypercube_config(name, 0, 0);
    dout = ['results_netgen_', config.name];
    clear config;
    
    
    
    load(fullfile(dout,'cube.mat'), 'config');
    
    assort_concat = zeros(config.num_pars, 1);
    G_concat = zeros(config.num_pars, 1);
    gconn_concat = zeros(config.num_pars, 1);
    pks_concat = zeros(config.num_pars, 1);
    pks_p1_concat = zeros(config.num_pars, 1);
    pks_p2_concat = zeros(config.num_pars, 1);
    ord_concat = zeros(config.num_pars, 1);
    ord_p1_concat = zeros(config.num_pars, 1);
    ord_p2_concat = zeros(config.num_pars, 1);
    for i = 1:config.num_pars
        load(fullfile(dout, ['out_', num2str(i), '.mat']), 'net', 'pvals', 'assort');
        
        assort_concat(i) = assort;
        G_concat(i)      = pvals(1);
        gconn_concat(i)      = pvals(2);
        pks_concat(i)    = mean(sum(net.pk_locs));
        pks_p1_concat(i)    = mean(sum(net.pk_locs(:, logical(net.pops))));
        pks_p2_concat(i)    = mean(sum(net.pk_locs(:, ~logical(net.pops))));
        ord_concat(i)    = net.ord;
        ord_p1_concat(i)    = net.ord_pops(2);
        ord_p2_concat(i)    = net.ord_pops(1);
    end
    clear i  net pvals assort config;
    save(fullfile(dout,'out_concat'));

end
