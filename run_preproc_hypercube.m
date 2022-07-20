function results = run_preproc_hypercube(din, basisfun, kernelfun)
    load(fullfile(din, 'out_concat.mat'));
    load(fullfile(din, 'cube.mat'));

    X = assort_concat;

    if round(std(G_concat), 4) ~= 0
        Y = G_concat;
    else
        Y = gconn_concat;
    end

    % Make order parameter 0 when there is no activity
    idx = pks_concat < (0.01 * max(pks_concat));
    ord_concat(idx) = 1e-7 * rand(length(sum(idx)), 1);
    idx = pks_p1_concat < (0.01 * max(pks_p1_concat));
    ord_p1_concat(idx) = 1e-7 * rand(length(sum(idx)), 1);
    idx = pks_p2_concat < (0.01 * max(pks_p2_concat));
    ord_p2_concat(idx) = 1e-7 * rand(length(sum(idx)), 1);

    [res.X_pred, res.Y_pred] = ...
        meshgrid(...
        linspace(min(X(:)), max(X(:)),240), ...
        linspace(min(Y(:)), max(Y(:)), 240));

    [res.pks_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], pks_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    [res.ord_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], ord_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    [res.pks_p1_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], pks_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    [res.pks_p2_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], pks_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    [res.ord_p1_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], ord_p1_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    [res.ord_p2_pred, ~, ~] = predict(fitrgp([X(:) Y(:)], ord_p2_concat(:), "Standardize",1, 'BasisFunction',basisfun, 'KernelFunction', kernelfun), [res.X_pred(:), res.Y_pred(:)]);
    res.pks_pred = reshape(res.pks_pred, size(res.X_pred));
    res.ord_pred = reshape(res.ord_pred, size(res.X_pred));
    res.pks_p1_pred = reshape(res.pks_p1_pred, size(res.X_pred));
    res.pks_p2_pred = reshape(res.pks_p2_pred, size(res.X_pred));
    res.ord_p1_pred = reshape(res.ord_p1_pred, size(res.X_pred));
    res.ord_p2_pred = reshape(res.ord_p2_pred, size(res.X_pred));
    % Not using for now
    %Z1sd = sqrt(Z1sd.^2 + gprMdl1_Z1.Sigma.^2);
    results = res;
    save(fullfile(din, 'out_gp.mat'), 'results');

end
