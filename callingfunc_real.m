function [W,c,e,Sigma, assets, unc_set] = callingfunc_real(confidence, tolerance);
% function [W,c,e,Sigma,var, unc_set, assets] = callingfunc_real()
window = 24
% unc_set = csvread("monthly_returns.csv", 1,1, [1 1 50 3]);
csv = readmatrix('monthly_returns2.csv')
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
unc_set = unc_set';
unc_setm = unc_setm';


[assets, total_points] = size(unc_set);
tolerance = 0.01; 
[W, c] = confidence_func(unc_setm, tolerance, confidence);
e=ones(assets,1);
Sigma = cov(unc_set')





