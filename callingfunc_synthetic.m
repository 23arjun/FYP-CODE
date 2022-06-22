function [W,c,e,Sigma, unc_set, assets] = callingfunc_synthetic(total_assets, total_points, confidence, var)
rng(30)
assets = total_assets;
unc_set = randn(total_assets, total_points);
tolerance = 0.01; 
[W, c] = confidence_func(unc_set, confidence,  tolerance);
e=ones(total_assets,1);
Sigma = cov(unc_set');



