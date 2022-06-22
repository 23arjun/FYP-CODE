function [R, c] = MinVolBall(A, tolerance);
% total_assets = 2;
% total_points = 100;
% A = randn(total_assets,total_points);
[total_assets total_points] = size(A);
tol = 0.001;
[alpha j_a] = max(vecnorm(A-A(:,1)));
[beta j_b] = max(vecnorm(A-A(:,j_a)));
u = zeros(total_points,1);
u(j_a,:) = 0.5;
u(j_b,:) = 0.5;
c = zeros(total_assets,1);
e = zeros(total_points,1);
core = [A(:,j_a), A(:,j_b)]; 
for i = 1:total_points
    c = c + u(i)*A(:,i);
end
gamma = 1/4*vecnorm(A(:,j_a)-A(:,j_b));
[x j_x] = max(vecnorm(A-c));
delta = (vecnorm(A(:,j_x)-c)/gamma)-1;
k = 0;

while delta > (1+tol)(1+tol)-1

    lambda = delta/(2*(1+delta));
    k = k+1;
    e = zeros(total_points,1);
    e(j_x,:) = 1;
    u = (1-lambda)*u + lambda*e;
    c = (1-lambda)*c + lambda*A(:,j_x);
    core(:,end+1) = A(:,j_x);
    gamma = gamma*(1+(delta*delta)/(4*(1+delta)));
    [x, j_x] = max(vecnorm(A-c));
    delta = (vecnorm(A(:,j_x)-c)/gamma)-1;

end
% plot(A(1,:), A(2,:), '*')
% hold on
% plot(c(1,:), c(2,:), 'sq')
% 
% c
gamma
R = max(vecnorm(A-c))
% circle(c(1,:), c(2,:), R)
% k
