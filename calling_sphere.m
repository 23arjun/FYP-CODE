function [R,c,e,Sigma,var, unc_set, assets] = calling_sphere(total_assets, total_points, confidence)
rng(30)
assets = total_assets;
unc_set = randn(total_assets, total_points);
tolerance = 0.01; 
[R, c] = confidence_func_ball(unc_set, tolerance, confidence)
e=ones(total_assets,1);
Sigma = cov(unc_set');
var=0.5;