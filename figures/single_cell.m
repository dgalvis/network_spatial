clear;clc;restoredefaultpath;close all;
addpath(fullfile('..','functions'));
dout = 'single_cell';

fn = class_fn;
fn.gl = 1;
fn.G = 1;
fn.run_ode(100);
fn.plot_me;
saveas(gcf, fullfile(dout,'FHN.png'));


srk = class_srk;
srk.gl = 0;
srk.G = 1;
srk.run_ode(50000);
srk.plot_me;
saveas(gcf, fullfile(dout,'SRK.png'));