[mu0, e,Sigma] = calling_NoUnc();
% variance = [0.0025, 0.004, 0.0045, 0.005, 0.01, 0.0124, 0.015, 0.0169];
var = 40;
assets = 3;
% returns = []
    cvx_begin sdp quiet
    

    % Define variables
    variable x(assets,1);,
    variable g(1);
    
    % Cost function
    maximize(g);
        %  Budget Constraint
            e'*x == 1;

        for i=1:assets
            x(i)>=0;
            x(i)<=1;
        end
        % Constraint on risk: x'*Sigma*x<=s; Schur gives
%         [var,x';x,inv(Sigma)]>=0;
        % Constraint on expected return
        mu0'*x>=g;
    
    cvx_end
% 
%     returns(end+1) = g;
% 
% end
% 
% plot(variance, returns)

mu0
x
g
x'*Sigma*x


