confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
gamma = []; 
risk = [];
volume = [];
var = 40;
for i = 1:11
    confidence = confidence_levels(i);
    
    [V, e,Sigma,var, unc_set, assets, A, b, zero, vol] = calling_polytope_facet(confidence);
    
    [i j] = size(A);
    
    cvx_begin sdp quiet
    
    % Define variables
    variable x(assets,1);
    variable g(1);
    variable v(i,1); 
    
        % Cost function
        maximize(g);
        % Constraints
        subject to
        %  Budget Constraint
            e'*x == 1; 
        %  Short Selling Constraint
            for i=1:assets
                x(i)>=0;
                x(i)<=1;
            end
        %  Alpha Constraint
           v>=0;
        %  Risk Constraint: x'*Sigma*x<=s
%            [var,x';x,inv(Sigma)]>=0;
            
        %  LMI     
           [g+b'*v+v'*b, -0.5*x'-v'*A; -0.5*x-A'*v, zero]<=0;
    
    cvx_end
    
    gamma(end+1) = g
    risk(end+1) = x'*Sigma*x
    volume(end+1) = vol;
    x
end
% 
% figure;
% plot(confidence_levels, gamma) 
% figure;
% plot(risk, gamma) 
% figure;
% plot(confidence_levels, risk)

figure;
subplot(3,1,1)
plot(confidence_levels, gamma) 
hold on
% yline(1.6336, 'r-')
% ylim([-15 2])
xlabel('Confidence Level')
ylabel('Gamma')
title('Gamma vs Confidence Level')
legend('Robust Model', 'Markowitz Model')
subplot(3,1,2)
plot(confidence_levels, risk)
hold on
% yline(48.1724, 'r-')t can
% ylim([-0.02 0.05])
xlabel('Confidence Level')
ylabel('Risk')
title('Risk vs Confidence Level')
legend('Robust Model', 'Markowitz Model')

subplot(3,1,3)
plot(risk, gamma) 
xlabel('Risk')
ylabel('Gamma')
title('Gamma vs Risk (at each confidence level)')
% legend('Robust Model', 'Markowitz Model')

% 
figure;
plot(confidence_levels, volume)
xlabel('Confidence Levels')
ylabel('Volume')

