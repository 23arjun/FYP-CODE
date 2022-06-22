function [V, e,Sigma,var, unc_set, assets, A, b, zero, vol] = calling_polytope_facet(confidence);

% unc_set = csvread("monthly_returns.csv", 1,1, [1 1 100 2]);
% unc_set = unc_set/100;
% [total_points, assets] = size(unc_set);

window = 24;
% unc_set = csvread("monthly_returns.csv", 1,1, [1 1 50 3]);
csv = readmatrix('monthly_returns2.csv');
asset1 = csv(:,1);
asset1m = movmean(asset1', window)';
asset2 = csv(:,2);
asset2m = movmean(asset2', window)';
asset3 = csv(:,3);
asset3m = movmean(asset3', window)';
asset4 = csv(:,4);
asset4m = movmean(asset4', window)';
asset5 = csv(:,5);
asset5m = movmean(asset5', window)';
asset6= csv(:,6);
asset6m = movmean(asset6', window)';

unc_set = [asset1, asset2, asset3]
unc_setm = [asset1m, asset2m, asset3m]

% unc_set = unc_set/100;
[total_points, assets] = size(unc_set);

[k vol] = convhulln(unc_setm,{'Qt', 'Qx'});
% C = unique(k) ;
% V = unc_set(C,:)  
% [A,b] = vert2lcon(V);

[A,b, V, k, reduced_set, vol] = confidence_polytope_facet(unc_setm, confidence);
% x = reduced_set(:,1);
% y = reduced_set(:,2);
% figure;
% plot(x(k),y(k),'r')
% hold on
% plot(unc_set(:,1),unc_set(:,2), '*')



zero = zeros(assets);
e=ones(assets,1);
% unc_set = unc_set';
Sigma = cov(unc_set);
var = 0.2; 