%load data
load(fullfile('results_hypercube_attempt_06', 'out_concat.mat'))
X = assort_concat;
Y = G_concat;%gconn_concat;
Z = pks_concat;


%what does this look like?
% figure(1)
% pcolor(X,Y, Z)
% shading('flat')
% grid
% %fit regression model
 gprMdl1 = fitrgp([X(:) Y(:)],Z(:), "Standardize",1);

%need some points we want to have the plot for
[X_pred, Y_pred] = meshgrid(linspace(min(X(:)), max(X(:)),240), linspace(min(Y(:)), max(Y(:))), 240);

%predict for these points
[Zpred,Zsd, ~] = predict(gprMdl1,[X_pred(:), Y_pred(:)]);

% by default, matlab only gives you mean uncertainty, not data uncertainty
%if we want data ucnertainty, we have to do the following line
Zsd = sqrt(Zsd.^2 + gprMdl1.Sigma.^2);

upper = Zpred + 2*Zsd;
lower = Zpred - 2*Zsd;

%do mean prediction (so this is what the plot is)
figure()
pcolor(X_pred,Y_pred, reshape(Zpred,size(X_pred)))
shading('flat')
xlim([min(X(:)), max(X(:))]);
ylim([min(Y(:)), max(Y(:))]);
grid;colorbar;caxis([0,max(Zpred(:))]);

figure()
pcolor(X_pred,Y_pred, reshape(Zsd,size(X_pred)))
shading('flat')
xlim([min(X(:)), max(X(:))]);
ylim([min(Y(:)), max(Y(:))]);
grid;colorbar;caxis([0,max(Zsd(:))]);

%do upper bound (This is an upper bound for what the plot is)
% figure()
% pcolor(X_pred,Y_pred, reshape(upper,size(X_pred)))
% shading('flat')
% grid;colorbar;
% 
% %lower bound 
% figure()
% pcolor(X_pred,Y_pred, reshape(lower,size(X_pred)))
% shading('flat')
% grid;colorbar;




