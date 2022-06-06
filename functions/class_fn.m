%=========================================================================%
% Function: class_fn.m
% Author: Daniel Galvis
%
% 11/05/2022
% code generation
%
% This class implements the Fitzhugh Namumo Model as an object. It can be
% called through class_network.m for a network or run as an individual unit
% using this class
%
% Properties include parameters, initial conditions, and trajectories
% If called as a network (using class_network.m), then it also uses
% num_vars = 2, num_nodes (number of nodes in the network), and gconns (a
% symmetric adjacency matrix of diffusive coupling strengths
%
%
%
% Example use
%
% gconns = [0,1;1,0]; % MUST BE SYMMETRIC
% Tmax = 1000;
% x = class_fn;
% x.make_network(gconns); %
% x.y0 = [-1; 0; -2; 0]; % ICs (1:2 node 1, 3:4 node 2)
% x.gl = 1; % "I" in FN model
% x.G  = 1; % Global Drive [0,1]
% x.run_ode(Tmax);
% x.gl = 2; % "I" in FN model
% x.G  = 1; % Global Drive [0,1]
% x.run_ode(Tmax);
% x.run_stats;
% x.plot_me;
% x.save_me('x');
% clear;
% x = class_fn('x');
%=========================================================================%


classdef class_fn < handle 
    properties
        
        % Parameters
        tau = 0.08;
        a   = 0.7;
        b   = 0.8;
        G   = 0; 
        gl = 0; % "I"
        
        % IC and trajectories
        y0        = [-1; 0];
        t         = [];
        y         = [];
        
        % For networks
        num_vars;
        num_nodes = 1;
        gconns    = 0;
        
        % For stats
        pk_t;
        pk_locs;
        pops;
        ord;
        ord_pops;
        t_mean;
        y_mean;
        y_pops;
    end
    methods
        % constructor (void input)
        function obj = class_fn(fname)
        
            if nargin < 1
                obj.num_vars = max(size(obj.y0));
            else
                obj = load_me(obj, fname);
            end        
        
        end
        
        % Can input adjacency matrix to add diffusive coupling
        function obj = make_network(obj, gconns)
            obj.num_nodes = length(gconns);
            y0_aux = zeros(obj.num_vars * obj.num_nodes, 1);
            for nv = 1:obj.num_vars
                y0_aux(nv:obj.num_vars:end) = obj.y0(nv);
            end
            obj.y0 = y0_aux;
            obj.gconns = gconns;
        end
        
        % Run the ode, Successive runs add to the trajectory
        function obj = run_ode(obj, tspan)

        
            % Run from y0 or continue!
            if ~isempty(obj.y)
                y_init = obj.y(end, :);
                t0 = obj.t(end);
            else
                y_init = obj.y0;
                t0 = 0;
            end
            
            % Run ode
            obj.gconns = sparse(obj.gconns);
            opts = odeset('Jacobian',@(t,y)jacob(obj,t,y),'RelTol', 1e-5);
            %opts = odeset('RelTol', 1e-5);
            [t_new, y_new] = ode15s(@(t, y)ode_step(obj, t, y), [0, tspan], y_init, opts);
            obj.t = [obj.t; t_new(2:end) + t0];
            obj.y = [obj.y; y_new(2:end,:)];
        end
        
        function obj = run_stats(obj, pops)
            
            if nargin < 2
                pops = zeros(obj.num_nodes, 1);
            end
            
            times = obj.t;
            x = obj.y(:, 1:obj.num_vars:end);
            % Get rid of transients
            [~,idx] = min(abs(times-times(end)/4));
            times = times(idx:end);
            x = x(idx:end,:);
            
            % Interpolate to regular time intervals
            inc = max(100, (max(times) - min(times))/min(10*nonzeros(diff(times))));
            t_new = linspace(min(times), max(times), inc)';
            x = interp1(times, x, t_new);
            times = t_new - min(times);
            
            % Save trajectory means
            obj.t_mean = times;
            obj.y_mean = mean(x,2);
            obj.y_pops = zeros(length(obj.y_mean), length(min(pops):max(pops)));
            ct = 1;
            for i = min(pops):max(pops)
                obj.y_pops(:,ct) = mean(x(:, pops == i), 2);
                ct = ct + 1;
            end           
            
            
            % Demean
            x = (x - mean(x));
            
            % Find peaks and locations
            obj.pk_locs = zeros(size(x));
            for i = 1:obj.num_nodes
                [~, locs] = findpeaks(x(:,i),'MinPeakProminence', 2);
                obj.pk_locs(locs, i) = 1;
            end
            obj.pk_locs = sparse(obj.pk_locs);
            obj.pk_t    = [min(times), min(diff(times)), max(times)];
            
            
            % Kuramoto order parameter
            obj.ord     = find_order_parameter(obj, x);
            obj.pops = pops;
            
            
            ct = 1;
            for i = min(pops):max(pops)
                obj.ord_pops(ct) = find_order_parameter(obj, x(:, pops == i));
                ct = ct + 1;
            end
           
        end
        
        % Save the object
        function save_me(obj, fname)
            save(fname, 'obj', '-v7.3');
        end
        
        % Plot the object
        function fig = plot_me(obj)
           fig = figure();
           subplot(211);hold all;
           plot(obj.t, obj.y(:,1:obj.num_vars:end), 'k', 'linewidth', 2);
           xlabel('time');
           ylabel('V');
           subplot(212);hold all;
           plot(obj.t, obj.y(:,2:obj.num_vars:end), 'r', 'linewidth', 2);
            xlabel('time');
           ylabel('W');       
        end
    end
    methods(Hidden = true, Access = protected)
        
        % Hidden method can be called with contructor to load a saved
        % object
        function obj = load_me(obj, fname)
            load(fname, 'obj');
        end
        % vector field
        function dy = ode_step(obj, ~, y)
            dy = zeros(length(y), 1);
            
            nconn = sum(obj.gconns,2);
            
            
            gj = nconn.*y(1:2:end) - obj.gconns * y(1:2:end);
            
            
            dy(1:2:end,1) = y(1:2:end) - y(1:2:end) .^ 3 / 3 - y(2:2:end) + obj.gl * obj.G - gj;
            dy(2:2:end,1) = obj.tau .* (y(1:2:end) + obj.a - obj.b .* y(2:2:end));
        end
        % jacobian
        function out = jacob(obj,~, y)
            
            elements = obj.num_vars * obj.num_nodes;
            out = zeros(elements, elements);
            
            out(1:(obj.num_vars*(elements + 1)):end) = 1 - y(1:2:end) .^ 2;
            out((1+elements):(obj.num_vars*(elements + 1)):end) = -1;
            out(2:(obj.num_vars*(elements + 1)):end) = obj.tau;
            out((2+elements):(obj.num_vars*(elements + 1)):end) = - obj.tau*obj.b;
            
            out(1:obj.num_vars:end, 1:obj.num_vars:end) = out(1:obj.num_vars:end, 1:obj.num_vars:end) + obj.gconns;
            
            out(1:(obj.num_vars*(elements + 1)):end) = out(1:(obj.num_vars*(elements + 1)):end) - sum(obj.gconns, 1);
            
            out = sparse(out);
        end
        
        function kur_ord_val = find_order_parameter(obj, x)
            
            % demean and find hilbert transform
            x_hil = hilbert(x - mean(x,1));
            
            % angles
            x_theta = angle(x_hil);
            
            % e^(-i*angles)
            x_exp = exp(1j * x_theta);
            % mean of the last ling
            x_exp_mean = mean(x_exp, 2);
            
            % order parameter at each time point
            kur_ord = abs(x_exp_mean);
            
            % average over all time points
            kur_ord_val = mean(kur_ord);
        end
        
    end
end