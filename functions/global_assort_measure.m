function global_sort = global_assort_measure(dists, population)

    p1 = logical(population);
    p2 = ~p1;
    
    
    mean_dists = mean(mean(nonzeros(dists) - 1)) ;
    p1p1 = nonzeros(dists(p1,p1)) - 1;
    p2p2 = nonzeros(dists(p2,p2)) - 1;

    p1p1 = (mean_dists - p1p1) / mean_dists;
    p2p2 = (mean_dists - p2p2) / mean_dists;

    mean_p1p1 = mean(p1p1);
    mean_p2p2 = mean(p2p2);

    global_sort = mean([mean_p1p1, mean_p2p2]);
end