function [ellipse1,center1, ellipse2, center2 ,e, Sigma,var, unc_1, unc_2, assets, intersect] = calling_multipleellipse(confidence, clusters, int_threshold)

window = 24
csv = readmatrix('monthly_returns2.csv');
asset1 = csv(:,1)
asset1m = movmean(asset1', window)'
asset2 = csv(:,2)
asset2m = movmean(asset2', window)'
asset3 = csv(:,3)
asset3m = movmean(asset3', window)'
asset4 = csv(:,4)
asset4m = movmean(asset4', window)'
asset5 = csv(:,5)
asset5m = movmean(asset5', window)'
asset6= csv(:,6)
asset6m = movmean(asset6', window)'

unc_set = [asset1, asset2, asset3];
unc_setm = [asset1m, asset2m, asset3m];
% unc_set = unc_set/100;
Y = unc_setm;
unc_set = unc_set';
unc_setm = unc_setm';
[assets, total_points] = size(unc_set);
% 
% X = csvread("monthly_returns.csv", 1,1, [1 1 100 2]);
% X = X/100;
% X = X';
% [assets, total_points] = size(X);
% Y = X';

[idx,c] = kmeans(Y,clusters);
vectors_1 = [];
vectors_2 = [];

for i = 1:assets
    vectors_1(:,end+1) = Y(idx==1,i);
    vectors_2(:,end+1) = Y(idx==2,i);
 
end
unc_1 = vectors_1';
unc_2 = vectors_2';

tolerance = 0.01;


[ellipse1, center1] = confidence_func(unc_1, tolerance, confidence);
[ellipse2, center2] = confidence_func(unc_2, tolerance, confidence);


intersection = []; 
for i = 1:100
    a = unc_set(:,i);

    if (a'-center1')*ellipse1*(a-center1) <= 1 && (a'-center2')*ellipse2*(a-center2) <= 1
        intersection(:,end+1) = a;

    end
end
intersect = false; 
[hi,num_intersect] = size(intersection);
num_intersect/total_points;
if num_intersect/total_points > int_threshold
    intersect = true; 
    
end

e=ones(assets,1);
Sigma = cov(unc_set');
% Sigma=randn(total_assets);
% Sigma=Sigma*Sigma';
var=45;