confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
volume = []; 
gamma = []; 
risk = [];
for i = 1:11
    confidence = confidence_levels(i);
    [R,c,e,Sigma,var, unc_set, assets] = calling_sphere(confidence)
    size(unc_set)
    % [R, c] = confidence_func_ball(unc_set, 0.01, 0.8)
    cvx_begin sdp quiet
    
    % Define variables
    variable x(assets,1);
    variable g(1);
    variable a(1);
    
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
            a>=0;
        
        %  Risk Constraint: x'*Sigma*x<=s
%            [var,x';x,inv(Sigma)]>=0;
        
        %  LMI Constraint
           [-a*R^2+(a*c'*c)-g, -a*c'+0.5*x'; -a*c+0.5*x, a*eye(assets)]>=0;
            
       cvx_end

    x
    g
    gamma(end+1) = g;
    risk(end+1) = x'*Sigma*x;
    volume(end+1) = ball_volume(R)
end
figure;
subplot(3,1,1)
plot(confidence_levels, gamma) 
% hold on
% yline(1.6336, 'r-');
% xlim([0 10])
% ylim([-30 6])
xlabel('Confidence Level')
ylabel('Gamma')
title('Gamma vs Confidence Level')
legend('Robust Model', 'Markowitz Model')

subplot(3,1,2)
plot(confidence_levels, risk)
% hold on 
% yline(48.1724, 'r-')
% ylim([30 120])
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


figure;
plot(confidence_levels, volume)
xlabel('Confidence Levels')
ylabel('Volume')
title('Volume vs Confidence Levels')
