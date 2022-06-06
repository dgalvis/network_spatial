%=========================================================================%
% Function: class_srk.m
% Author: Daniel Galvis
%
% 05/03/2021
% code generation
%
% This class implements the Sherman Rinzel Keizer Model as an object. It can be
% called through class_network.m for a network or run as an individual unit
% using this class
%
% Properties include parameters, initial conditions, and trajectories
% If called as a network (using class_network.m), then it also uses
% num_vars = 3, num_nodes (number of nodes in the network), and gconns (a
% symmetric adjacency matrix of diffusive coupling strengths
%
% 
% Example use
%
% gconns = [0,10;10,0]; % MUST BE SYMMETRIC
% Tmax = 360000;
% x = class_srk;
% x.make_network(gconns); %
% x.y0 = [-68.0; 0.00; 0.57;-30; 0.00; 0.02]; % ICs (1:2 node 1, 3:4 node 2)
% x.gl = [100;60]; % "gl" in SRK model
% x.G  = 1; % Global Drive [0,1]
% x.run_ode(Tmax);
% x.gl = [60;60]; % "gl" in SRK model
% x.G  = 1; % Global Drive [0,1]
% x.run_ode(Tmax);
% x.run_stats;
% x.plot_me;
% x.save_me('x');
% clear;
% x = class_srk('x');
%=========================================================================%

classdef class_srk < handle 
    properties
        % parameters
        cm        = 5310.0;
        vm        = 4.0;
        sm        = 14.0;
        vn        = -15.0;
        sn        = 5.6;
        a         = 65.0;
        b         = 20.0;
        c         = 60.0;
        vbar      = -75.0;
        vh        = -10.0;
        sh        = 10.0;
        gk        = 2500.0;
        gca       = 1400.0;
        vk        = -75.0;
        vca       = 110.0;
        lambda    = 1.6;
        kd        = 100.0;
        gkca      = 30000.0;
        f         = 0.001;
        kca       = 0.03;
        alpha     = 0.0000045061;
        gl         = 0;
        G         = 0;
        
        % IC and trajectories
        y0        = [-68.0; 0.00; 0.57];
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
        function obj = class_srk(fname)
        
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
            x = obj.y(:, 3:obj.num_vars:end);
            
            % Get rid of transients
            [~,idx] = min(abs(times-times(end)/4));
            times = times(idx:end);
            x = x(idx:end,:);
            
            % Interpolate to regular time intervals
            inc = max(100, (max(times) - min(times))/min(100*nonzeros(diff(times))));
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
            
            % Standardise
            x = (x - mean(x));
            
            % Find peaks and locations
            obj.pk_locs = zeros(size(x));
            for i = 1:obj.num_nodes
                [~, locs] = findpeaks(x(:,i),'MinPeakProminence', 0.02);
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
            
            obj.t_mean = times;
            
        end
        
        % Save the object
        function save_me(obj, fname)
            save(fname, 'obj', '-v7.3');
        end
        
        % Plot the object
        function fig = plot_me(obj)
           fig = figure();
           subplot(311);hold all;
           plot(obj.t, obj.y(:,1:obj.num_vars:end), 'k', 'linewidth', 2);
           xlabel('time ms');
           ylabel('V (mV)');
           subplot(312);hold all;
           plot(obj.t, obj.y(:,2:obj.num_vars:end), 'r', 'linewidth', 2);
            xlabel('time ms');
           ylabel('h (au)');
           subplot(313);hold all;
           plot(obj.t, obj.y(:,3:obj.num_vars:end), 'b', 'linewidth', 2);   
           xlabel('time ms');
           ylabel('ca2+ (\muM)');           
        end
    end
    
    methods(Hidden = true, Access = protected)
        % Hidden method can be called with contructor to load a saved
        % object
        function obj = load_me(obj, fname)
            load(fname, 'obj');
        end
        
        % vector field
        function dy = ode_step(obj, t, y)
            function out = xinf(v, vx, sx)
                out =  (1 ./ (1 + exp((vx - v) ./ sx)));
            end
            function out = taun(v, a, b, c, vbar)
                out = (c ./ (exp((v - vbar) ./ a) + exp(- (v - vbar) ./ b)));
            end
            function out = hill(c, k)
                out = (c ./ (c + k));
            end

            dy = zeros(size(y));
            one = 1:obj.num_vars:(obj.num_vars * obj.num_nodes);
            two = 2:obj.num_vars:(obj.num_vars * obj.num_nodes);
            three = 3:obj.num_vars:(obj.num_vars * obj.num_nodes);
            
            yone = y(one);
            ytwo = y(two);
            ythree = y(three);
            
            
            ica     = obj.gca .* ...
                      xinf(yone, obj.vm, obj.sm) .* ...
                      xinf(obj.vh, yone, obj.sh) .* ...
                      (yone - obj.vca);
                  
                  
            k_drive = (yone - obj.vk);
            k_cond  =  obj.gk .* ytwo + obj.gkca .* hill(ythree, obj.kd) + (1 - obj.G) * obj.gl;

            
            nconn = sum(obj.gconns,2);
            
           
            gj = nconn.*yone - obj.gconns * yone;
            
            
            
            
            
            dy(one) = (- k_cond .* k_drive - ica - gj) ./ obj.cm;
            dy(two) = obj.lambda .* (xinf(yone, obj.vn, obj.sn) - ytwo)  ./ ...
                taun(yone, obj.a, obj.b, obj.c, obj.vbar);
            dy(three) = - obj.f .* (obj.alpha .* ica  +  obj.kca .* ythree);            
            
        end
        
        % jacobian
        function out = jacob(obj,t, y)
            function out = dica_dv(v, obj)

                aux1 = (exp((obj.vm - v) ./ obj.sm) + 1);
                aux2 = (exp((v - obj.vh) / obj.sh) + 1) ;

                num1 = obj.gca .* (v - obj.vca) .* exp((v - obj.vh) ./ obj.sh);
                denom1 = obj.sh * aux1 .* aux2 .^2;

                num2 = obj.gca;
                denom2 = aux1 .* aux2; 

                out = num1 ./ denom1 - num2 ./ denom2;

            end

            function out = dg_dn(v, obj)

                aux1 = exp((v - obj.vbar) ./ obj.a);
                aux2 = exp(-(v - obj.vbar) ./ obj.b);


                num = - obj.lambda;
                denom =  obj.c ./ (aux1 + aux2);

                out = num ./ denom;
            end

            function out = dg_dv(v, n, obj)

                aux1 = (1 ./ (exp((obj.vn - v) ./ obj.sn) + 1) - n);
                aux2 = exp((v - obj.vbar) ./ obj.a);
                aux3 = exp(-(v - obj.vbar) ./ obj.b);

                num1 = aux1 .* (aux2 ./ obj.a - aux3 ./ obj.b);
                denom1 = obj.c;

                aux4 = exp((obj.vn - v) ./ obj.sn);

                num2 = aux4 .* (aux2 + aux3);
                denom2 = obj.sn .* obj.c .* ((aux4 + 1) .^ 2);

                out = num1 ./ denom1 + num2 ./ denom2;


            end

            out = zeros(length(y));
            elements = obj.num_nodes * obj.num_vars;

            one = 1:obj.num_vars:elements;
            two = 2:obj.num_vars:elements;
            three = 3:obj.num_vars:elements;

            v = y(one);
            n = y(two);
            ca = y(three);


            out(1:(3*(elements + 1)):end) = (- obj.gk .* n - obj.gkca .* ca ./ (obj.kd + ca) - dica_dv(v, obj) - (1-obj.G) * obj.gl) ./ obj.cm;
            out((1+elements):(3*(elements + 1)):end) = (- obj.gk .* (v - obj.vk)) ./ obj.cm;
            out((1+2*elements):(3*(elements + 1)):end) = (- obj.gkca .* (v - obj.vk) .* obj.kd ./ ((obj.kd + ca) .^2)) ./ obj.cm;


            out(2:(3*(elements + 1)):end)  = obj.lambda .* dg_dv(v, n, obj);

            out((2+elements):(3*(elements + 1)):end) = dg_dn(v, obj);
            out((2+2*elements):(3*(elements + 1)):end) = 0;

            out(3:(3*(elements + 1)):end) = - obj.f .* obj.alpha .* dica_dv(v, obj);
            out((3+elements):(3*(elements + 1)):end) = 0;
            out((3+2*elements):(3*(elements + 1)):end) = - obj.f .* obj.kca; 

            out(1:obj.num_vars:end, 1:obj.num_vars:end) = out(1:obj.num_vars:end, 1:obj.num_vars:end) + obj.gconns ./ obj.cm;

            out(1:(3*(elements + 1)):end) = out(1:(3*(elements + 1)):end) - sum(obj.gconns, 1) ./ obj.cm;

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
