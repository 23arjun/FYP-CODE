function [mu0, e,Sigma] = calling_NoUnc();
% function [W,c,e,Sigma,var, unc_set, assets] = callingfunc_real()

window = 24
csv = readmatrix('monthly_returns2.csv');
asset1 = csv(:,1)
% asset1m = movmean(asset1', window)'
asset2 = csv(:,2)
% asset2m = movmean(asset2', window)'
asset3 = csv(:,3)
% asset3m = movmean(asset3', window)'
asset4 = csv(:,4)
% asset4m = movmean(asset4', window)'
asset5 = csv(:,5)
% asset5m = movmean(asset5', window)'
asset6= csv(:,6)
% asset6m = movmean(asset6', window)' 

% unc_set_m = [asset1m, asset2m, asset3m]
unc_set = [asset1, asset2, asset3]



% unc_set = unc_set/100
unc_set = unc_set';
% unc_set_m = unc_set_m'
e=ones(3,1);
% Sigma = cov(unc_set(:,75:end)');
Sigma = cov(unc_set')
% Sigma=randn(3,3);Sigma=Sigma*Sigma'
mu0 = mean(unc_set,2);
% mu0 = mu0'




