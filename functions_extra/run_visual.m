%% Setup
clear;clc;close all;
addpath('functions');
din = fullfile('results_directory','results_netgen_attempt_05');
results = preproc_hypercube(din);

surf(results.X_pred, results.Y_pred, results.ord_pred);
shading interp;



%FN, Hypercube, G, Strong
% Z1_contour = [50, 50];
% Z2_contour = [0.9, 0.9];
% din = fullfile('results_directory','results_hypercube_attempt_01');

%FN, Hypercube, G, Weak
%Z1_contour = [5, 5, 50];
%Z2_contour = [0.9, 0.9];
%din = fullfile('results_directory','results_hypercube_attempt_03');

% SRK, Hypercube, G, Strong
% Z1_contour = [5, 5];
% Z2_contour = [0.9, 0.9];
% din = fullfile('results_directory','results_hypercube_attempt_04');
%SRK, Hypercube, G, Middle
%Z1_contour = [5, 5, 8];
%Z2_contour = [0.9, 0.9];
%din = fullfile('results_directory','results_hypercube_attempt_05');
%SRK, Hypercube, G, Weak
% Z1_contour = [5, 5,];
% Z2_contour = [0.9, 0.9];
% din = fullfile('results_directory','results_hypercube_attempt_06');

%SRK, Netgen, G, Weak
%Z1_contour = [5, 5, 8, 13];
%Z2_contour = [0.9, 0.9];


%% Contour plots

    figure('renderer', 'Painters');
    set(gcf, 'position', [10, 10, 1000, 500]);
    subplot(121);hold all;
    pcolor(X_pred,Y1_pred, Z1_pred)
    shading('flat')
    xlim([min(X(:)), max(X(:))]);
    ylim([min(Y1(:)), max(Y1(:))]);
    grid;a = colorbar;caxis([0,max(Z1_pred(:))]);
    xlabel('sortedness');
    ylabel('G');
    a.Label.String = 'peaks';
    contour(X_pred, Y1_pred,Z1_pred, Z1_contour, 'w', 'linewidth', 2);


    subplot(122);hold all;
    pcolor(X_pred,Y1_pred, Z2_pred);
    shading('flat')
    xlim([min(X(:)), max(X(:))]);
    ylim([min(Y1(:)), max(Y1(:))]);
    grid;a = colorbar;caxis([0,max(Z2_pred(:))]);
    xlabel('sortedness');
    ylabel('G');
    a.Label.String = 'order';
    contour(X_pred, Y1_pred,Z2_pred, Z2_contour, 'w', 'linewidth', 2);
    
    
    figure();
    surf(X_pred, Y1_pred, Z1_pred);
    shading interp;

