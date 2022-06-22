function [V, e,Sigma,var, unc_set, assets, A, b, zero, vol] = calling_polytope_facet(total_assets, total_points, confidence)
% 
% unc_set = csvread("monthly_returns.csv", 1,1, [1 1 100 2]);
% unc_set = unc_set/100;
% [total_points, assets] = size(unc_set);

rng(30)
assets = total_assets;
unc_set = randn(total_points, total_assets);

% [k vol] = convhulln(unc_set,{'Qt', 'Qx'})
[k vol] = convhulln(unc_set);


[A,b, V, k, reduced_set, vol] = confidence_polytope_facet(unc_set, confidence);
x = reduced_set(:,1);
y = reduced_set(:,2);
% figure;
% plot(x(k),y(k),'r')

zero = zeros(assets);
e=ones(assets,1);
Sigma = cov(unc_set);
var = 0.3; 