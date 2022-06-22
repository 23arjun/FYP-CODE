confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
gamma = [];
risk = [];
volume = [];
var = 50;
for i = 1:11
    
    confidence = confidence_levels(i);
    [W,c,e,Sigma, unc_set, assets] = callingfunc_synthetic(2,200, confidence, var);
    
%     confidence = confidence_levels(i) 
%     [W, c] = confidence_func(unc_set, 0.1, confidence);
%     Ellipse_plot(W,c)
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
           [(a*c'*W*c)-a-g, 0.5*x'-a*c'*W; 0.5*x-a*W*c, a*W] >=0;
        
    cvx_end

    gamma(end+1) = g;
    risk(end+1) = x'*Sigma*x
    volume(end+1) = ellipse_volume(W)

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
title('Volume vs Confidence Level')

Ellipse_plot(W,c)
xlabel("Asset 1")
ylabel("Asset 2")


