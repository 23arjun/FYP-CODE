confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
gamma = []; 
risk = [];
volume = [];
for i = 1:11
    confidence = confidence_levels(i);
    
    [V, e,Sigma,var, unc_set, assets, A, b, zero, vol] = calling_polytope_facet(15,200, confidence);
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
           [0.37,x';x,inv(Sigma)]>=0;
            
        %  LMI     
           [g+b'*v+v'*b, -0.5*x'-v'*A; -0.5*x-A'*v, zero]<=0;
    
    cvx_end
%     
    gamma(end+1) = g
    risk(end+1) = x'*Sigma*x
    volume(end+1) = vol
    x
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
