function make_raster(pk_t, pk_locs, pops, flag, order)

    if nargin < 4
        flag = 'random';
    end
    t = pk_t(1):pk_t(2):pk_t(3);
    
    if strcmp(flag, 'random')
        j = randperm(size(pk_locs, 2));
        ct1 = 1;
        ct2 = 1;
        for i = 1:size(pk_locs, 2)

            idx = find(pk_locs(:,j(i)));

            if pops(j(i))
                scatter(t(idx), ct1*ones(size(t(idx))), 10, 'filled', 'b');
                ct1 = ct1 + 1;
            else
                scatter(t(idx), ct2*ones(size(t(idx))) - 1000, 10, 'filled', 'k');
                ct2 = ct2 + 1;
            end
        end

    elseif strcmp(flag, 'order') && nargin == 4
        ct1 = 1;
        for i = 1:size(pk_locs, 2)
            
            idx = find(pk_locs(:,i));

            if pops(i)
                scatter(t(idx), ct1*ones(size(t(idx))), 30, 'filled', 'b');

            else
                scatter(t(idx), ct1*ones(size(t(idx))), 10, 'filled', 'k');
    
            end
            ct1 = ct1 + 1;
        end
    elseif strcmp(flag, 'order') && nargin == 5
        ct1 = 1;
        for j = 1:length(order)
            i = order(j);
            idx = find(pk_locs(:,i));

            if pops(i)
                scatter(t(idx), -ct1*ones(size(t(idx))), 30, 'filled', 'b');

            else
                scatter(t(idx), -ct1*ones(size(t(idx))), 10, 'filled', 'k');
    
            end
            ct1 = ct1 + 1;
        end
    end
    axis tight
    yticks([]);
    yticklabels({});
    
    
end
