function make_raster(pk_t, pk_locs, pops)
    t = pk_t(1):pk_t(2):pk_t(3);
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
    axis tight
    yticks([]);
    yticklabels({});
end
