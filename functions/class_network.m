classdef class_network < handle 
    properties
        dims = 3;
        radius = 5.55;
        r_ball = 0.5;
        
        gmean = 0;
        gstd  = 0;
        
        num_nodes;
        num_conns;
        index;
        conns;
        gconns;
        sys;
        
        node_class;
        
        tocs;
    end
    methods
        % constructor (void input)
        function obj = class_network(fname)
            if nargin < 1
                obj = initialise(obj);
            else
                obj = load_me(obj, fname);
            end
        end
        function obj = initialise(obj, node_class)
                
                if nargin < 2
                    obj.node_class = 'srk';
                else
                    obj.node_class = node_class;
                end
                
                obj.tocs = 0;
                obj = find_index(obj);
                obj = find_connections(obj);
                if strcmp(obj.node_class, 'srk')
                    obj.sys = class_srk;
                elseif strcmp(obj.node_class, 'fn')
                    obj.sys = class_fn;
                else
                    error('initialise("srk") or ("fn") only');
                end
                obj = find_g(obj);
                                 
                obj.sys.make_network(obj.gconns);
                
        end
        function obj = run_ode(obj, tspan)
            tic;
            obj.sys.run_ode(tspan);
            obj.tocs = obj.tocs + toc;
        end
        function save_me(obj, fname)
            save(fname, 'obj', '-v7.3');
        end
        function obj = plot_me(obj)
           figure(obj.sys.plot_me()); 
        end
        function out = lognormals(obj, means, stds, shape)

            if nargin < 4
                shape = [obj.num_nodes, 1];
            end
            
            mu         = log(means^2 / sqrt(stds^2 + means^2));
            sig        = sqrt(log(stds^2 / means^2 + 1));
            if means > 0
                out        = lognrnd(mu, sig, shape);   
            else
                out        = zeros(shape);
            end
        end  
    end
    methods(Hidden = true, Access = protected)
        function obj = load_me(obj, fname)
            load(fname, 'obj');
        end  
        function obj = find_index(obj)
            R_net = obj.radius;
            %r_ball = 0.5;
            d_ball = 2 * obj.r_ball;

            x_scale = d_ball;
            y_scale = sqrt(d_ball^2 - obj.r_ball^2);
            z_scale = sqrt(2/3)*d_ball;%sqrt(d_ball ^ 2 - d_ball ^ 2 / 3);

            x_shift = obj.r_ball;
            y_shift = - d_ball / sqrt(3);

            N = ceil(2*R_net/ min([x_scale, y_scale, z_scale])) + 100 ;

            x = zeros(N^obj.dims, 1);
            y = zeros(N^obj.dims, 1);
            z = zeros(N^obj.dims, 1);

            ct = 1;
            N1 = N;N2 = N;N3 = N;
            if obj.dims == 2
                N1 = 1;
            elseif obj.dims == 1
                N1 = 1;
                N2 = 1;
            end
            
            for i = 1:N1
                for j = 1:N2
                    for k = 1:N3
                        x(ct) = k * x_scale;
                        y(ct) = j * y_scale;
                        z(ct) = i * z_scale;
                        if (mod(j, 2) == 0)
                            x(ct) = x(ct) + x_shift;
                        end
                        if (mod(i, 2) == 0)
                            y(ct) = y(ct) + y_shift;
                        end

                        ct = ct + 1;
                    end
                end
            end

            x = x - mean(x);
            y = y - mean(y);
            z = z - mean(z);
            r = vecnorm([x,y,z], 2, 2);


            x = x(r <= R_net);
            y = y(r <= R_net);
            z = z(r <= R_net);
            %r = r(r <= R_net);
            
            if obj.dims == 3
                obj.index = [(1:length(x))', x, y, z];
            elseif obj.dims == 2
                obj.index = [(1:length(x))', x, y];
            elseif obj.dims == 1
                obj.index = [(1:length(x))', x];
            end
            
            %obj.index = [(1:length(x))', x, y, z];
            obj.num_nodes = length(x);
            
            conns_aux = zeros(length(x));
            for i = 1:size(x,1)
                for j = 1:size(x,1) 
                    dists =  norm([x(i) - x(j), y(i)-y(j),z(i)-z(j)]);
                    if abs(dists - d_ball) < 0.0001
                        conns_aux(i,j) = 1;
                    end
                end
            end
            
            obj.conns = conns_aux;
            obj.num_conns = sum(conns_aux(:)) / 2;
       
        end
        function obj = find_connections(obj)
            return
        end
        
        
%         function obj = find_index(obj)
%             grid = ceil(8 * obj.radius);
%             
%             % Define grid
%             if obj.dims == 1
%                 points.X = 1:grid;
%             elseif obj.dims == 2
%                 [points.X, points.Y] = meshgrid(1:grid);  
%             elseif obj.dims == 3
%                 [points.X, points.Y, points.Z] = meshgrid(1:grid);
%             else
%                 error('dimensions can be 1 2 or 3 for find_index');
%             end            
%             obj = circle_hex_index(obj, points);
%             obj.num_nodes = size(obj.index, 1);
%         end
%         function obj = find_connections(obj)
%             dist = zeros(size(obj.index, 1), size(obj.index, 1));
% 
%             for i = 1:(size(obj.index, 1) - 1)
%                 for j = (i + 1):size(obj.index, 1)
%                     dist(i, j) = norm(obj.index(i, 2:end) - obj.index(j, 2:end));
%                     dist(j, i) = dist(i, j);
%                 end
%             end
%             dist     = round(dist,4); % avoid rounding errors
%             obj.max_dist = round(obj.max_dist, 4); % avoid rounding errors
% 
%             obj.conns    =  (dist <= obj.max_dist) & (dist > 0); % connections (no self)
%             obj.num_conns = sum(obj.conns(:))/2;
%         end
%         function obj = circle_hex_index(obj, points)
%        
% 
%             obj = hexagon_index(obj, points);
%             obj = translate_index(obj);
% 
%             % define the limit of the circle
%             limit = round(obj.radius, 4);
% 
%             % find all points in index that fall in the circle
%             if obj.dims == 1
%                 return
% 
%             elseif obj.dims == 2
%                 w = round(sqrt(obj.index(:,2) .^ 2 + obj.index(:,3) .^ 2), 4);
%                 keep = w <= limit;
%                 obj.index = obj.index(keep,:);
% 
% 
%             elseif obj.dims == 3
%                 w = round(sqrt(obj.index(:,2) .^ 2 + obj.index(:,3) .^ 2 + obj.index(:,4) .^ 2), 4);
%                 keep = w <= limit;
%                 obj.index = obj.index(keep,:);
% 
%             else
%                 error('dimensions can be 1 2 or 3 for circle');
%             end
% 
%             % reindex the output
%             obj.index(:,1) = 1:size(obj.index,1);
%         end
%         function obj = hexagon_index(obj, points)
% 
%             obj = box_index(obj, points);
% 
%             if obj.dims == 1
% 
%                 return;
% 
%             elseif obj.dims == 2
% 
%                 shift = mod(obj.index(:,2),2) == 1;
%                 obj.index(shift,3) = obj.index(shift,3) + 1/2;
%                 obj.index(:,2) = obj.index(:,2)*sqrt(3)/2;
% 
% 
%             elseif obj.dims == 3
% 
%                 xshift = mod(obj.index(:,2),2) == 1;
%                 zshift = mod(obj.index(:,4),2) == 1;
% 
%                 xshift1 = xshift & ~zshift;
%                 xshift2 = ~xshift & zshift;
%                 xshift  = xshift1 | xshift2;
%                 obj.index(xshift,3) = obj.index(xshift,3) + 1/2;
% 
%                 obj.index(zshift,2) = obj.index(zshift,2) + 1/2;        
%                 obj.index(:,2) = obj.index(:,2)*sqrt(3)/2;  
%                 obj.index(:,4) = obj.index(:,4)*3/4;
% 
%             else
%                 error('dimensions can be 1 or 2 for hexagon');
%             end
% 
%         end
%         function obj = box_index(obj, points)
% 
% 
%             obj.index = zeros([size(points.X(:),1), obj.dims + 1]);
%             obj.index(:,1) = (1:size(points.X(:)));
% 
%             if obj.dims == 1     
% 
%                 obj.index(:,2) = points.X(:);
% 
%             elseif obj.dims == 2
% 
%                 obj.index(:,2) = points.X(:);
%                 obj.index(:,3) = points.Y(:);
% 
% 
%             elseif obj.dims == 3
% 
%                 obj.index(:,2) = points.X(:);
%                 obj.index(:,3) = points.Y(:);
%                 obj.index(:,4) = points.Z(:);
% 
% 
%             else
%                 error('dimensions can be 1 2 or 3 for box');
%             end
%     
%         end
%         function obj = translate_index(obj)
% 
% 
% 
%             % Shift grid so it centers near zero
%             if obj.dims == 1
% 
%                 obj.index(:,2) = obj.index(:,2) - median(obj.index(:,2));
% 
%             elseif obj.dims == 2
% 
%                 obj.index(:,2) = obj.index(:,2) - median(obj.index(:,2));
%                 obj.index(:,3) = obj.index(:,3) - median(obj.index(:,3));
% 
%             elseif obj.dims == 3
% 
%                 obj.index(:,2) = obj.index(:,2) - median(obj.index(:,2));
%                 obj.index(:,3) = obj.index(:,3) - median(obj.index(:,3));
%                 obj.index(:,4) = obj.index(:,4) - median(obj.index(:,4));
% 
%             else
%                 error('dimensions can be 1 2 or 3 for circle');
%             end
% 
%             % Pick a new node near the origin and shift so that it is at the origin
%             [~,zidx] = min( sqrt( sum( obj.index(:,2:end) .^ 2, 2 ) ) );
%             obj.index(:,2:end) = obj.index(:,2:end) - obj.index(zidx,2:end);
% 
%         end
        function obj = find_g(obj)
            obj.gconns = lognormals(obj, obj.gmean, obj.gstd, size(obj.conns)) .* triu(obj.conns); 
            obj.gconns = obj.gconns + obj.gconns';
        end
    end
end