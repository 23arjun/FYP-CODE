confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
gamma = [];
risk = [];
volume = []
var = 0.5;
for i = 1:11
    
    confidence = confidence_levels(i);
    [R,c,e,Sigma,var, unc_set, assets] = calling_sphere(3, 200, confidence);
    % cvx_solver sedumi
    
%     [R, c] = confidence_func_ball(unc_set, 0.01, 0.3)
    % [R, c] = MinVolBall(unc_set, 0.01)
    
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
           [var,x';x,inv(Sigma)]>=0;
        
        %  LMI Constraint
           [-a*R^2+(a*c'*c)-g, -a*c'+0.5*x'; -a*c+0.5*x, a*eye(assets)]>=0;
            
       cvx_end

       gamma(end+1) = g;
       risk(end+1) = x'*Sigma*x
       volume(end+1) = ball_volume(R)

end
figure;
subplot(3,1,1)
plot(confidence_levels, gamma) 
xlabel('Confidence Level')
ylabel('Gamma')
title('Gamma vs Confidence Level')
subplot(3,1,2)
plot(confidence_levels, risk)
xlabel('Confidence Level')
ylabel('Risk')
title('Risk vs Confidence Level')
subplot(3,1,3)
plot(risk, gamma) 
xlabel('Risk')
ylabel('Gamma')
title('Gamma vs Risk (at each confidence level)')

figure;
plot(confidence_levels, volume)
xlabel('Confidence Levels')
ylabel('Volume')
title('Volume vs Confidence Levels')
%  x
%  g
%  figure;
%  circle(c(1,:), c(2,:), R)
%  hold on
%  plot(unc_set(1,:), unc_set(2,:), '*')