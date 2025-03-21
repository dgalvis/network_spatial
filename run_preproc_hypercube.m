function results = run_preproc_hypercube(din, basisfun, kernelfun, predictfun)
    load(fullfile(din, 'out_concat.mat'), 'pks_concat', 'ord_concat', ...
        'pks_p1_concat', 'pks_p2_concat', 'ord_p1_concat', 'ord_p2_concat', ...
        'assort_concat', 'G_concat', 'gconn_concat');
    load(fullfile(din, 'cube.mat'), 'config');
    

    X = assort_concat;
    check = false;
    if (round(std(G_concat/mean(G_concat)), 4) ~= 0) && (round(std(gconn_concat/mean(gconn_concat)), 4) ~= 0)
        disp('3D GP');
        Y1 = gconn_concat;
        Y2 = G_concat;
        check = true;
    elseif round(std(G_concat), 4)
        disp('2D GP wrt G');
        Y = G_concat;
    else     
        disp('2D GP wrt gconn');
        Y = gconn_concat;
    end

    if ~check
        [res.X_pred, res.Y_pred] = ...
            meshgrid(...
            linspace(min(X(:)), max(X(:)),240), ...
            linspace(min(Y(:)), max(Y(:)), 240));
        
        [res.pks_pred] = predict(fitrgp([X(:) Y(:)], pks_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);
        [res.ord_pred] = predict(fitrgp([X(:) Y(:)], ord_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);
        [res.pks_p1_pred] = predict(fitrgp([X(:) Y(:)], pks_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);
        [res.pks_p2_pred] = predict(fitrgp([X(:) Y(:)], pks_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);
        [res.ord_p1_pred] = predict(fitrgp([X(:) Y(:)], ord_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);
        [res.ord_p2_pred] = predict(fitrgp([X(:) Y(:)], ord_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y_pred(:)]);

    else
        [res.X_pred, res.Y1_pred, res.Y2_pred] = ...
            meshgrid(...
            linspace(min(X(:)), max(X(:)), 100), ...
            linspace(min(Y1(:)), max(Y1(:)), 100), ...
            linspace(min(Y2(:)), max(Y2(:)), 100));
        
        [res.pks_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], pks_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);
        [res.ord_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], ord_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);
        [res.pks_p1_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], pks_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);
        [res.pks_p2_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], pks_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);
        [res.ord_p1_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], ord_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);
        [res.ord_p2_pred] = predict(fitrgp([X(:) Y1(:) Y2(:)], ord_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun, 'PredictMethod', predictfun), [res.X_pred(:), res.Y1_pred(:),res.Y2_pred(:)]);

    end
    
    res.pks_pred = reshape(res.pks_pred, size(res.X_pred));
    res.ord_pred = reshape(res.ord_pred, size(res.X_pred));
    res.pks_p1_pred = reshape(res.pks_p1_pred, size(res.X_pred));
    res.pks_p2_pred = reshape(res.pks_p2_pred, size(res.X_pred));
    res.ord_p1_pred = reshape(res.ord_p1_pred, size(res.X_pred));
    res.ord_p2_pred = reshape(res.ord_p2_pred, size(res.X_pred));
    
    
    % Not using for now
    %Z1sd = sqrt(Z1sd.^2 + gprMdl1_Z1.Sigma.^2);
    results = res;
    results.config = config;
    save(fullfile(din, 'out_gp.mat'), 'results');

end
