function [ellipse1,center1, ellipse2, center2 ,e, Sigma,var, unc_1, unc_2, assets, intersect] = calling_multipleellipse(total_assets, total_points, confidence, clusters, int_threshold)
rng(30)
assets = total_assets; 
X = randn(total_assets,total_points);
Y = X';

[idx,c] = kmeans(Y,clusters);
vectors_1 = [];
vectors_2 = [];

for i = 1:total_assets
    vectors_1(:,end+1) = Y(idx==1,i)
    vectors_2(:,end+1) = Y(idx==2,i)
 
end
unc_1 = vectors_1'
unc_2 = vectors_2'

tolerance = 0.01;


[ellipse1, center1] = confidence_func(unc_1, confidence, tolerance)
[ellipse2, center2] = confidence_func(unc_2, confidence, tolerance)

intersection = []; 
for i = 1:100
    a = X(:,i);

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

e=ones(total_assets,1);
% Sigma=randn(total_assets);
% Sigma=Sigma*Sigma';
Sigma = cov(X');
var=1;


