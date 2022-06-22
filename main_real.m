
%%  Gamma for different ellipse confidence levels
confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
% var = 30;
gamma = []; 
risk = [];
volume = [];

for i = 1:11
    confidence = confidence_levels(i);
    [W,c,e,Sigma, assets, unc_set] = callingfunc_real(confidence, 0.0001);
  
    cvx_begin sdp quiet
    
    % Define variables
    variable x(assets,1);,
    variable a(1);
    variable g(1);
    
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
        
        %  Risk Constraint: x'*Sigma*x<=var
%            [var,x';x,inv(Sigma)] >= 0

        %  LMI Constraint
           [(a*c'*W*c)-a-g, 0.5*x'-a*c'*W; 0.5*x-a*W*c, a*W] >= 0

    cvx_end

    gamma(end+1) = g;
    risk(end+1) = x'*Sigma*x;
    if assets == 3
        volume(end+1) = ellipse_volume(W);
    end
%   
    g
end

figure;
subplot(3,1,1)
plot(confidence_levels, gamma) 
hold on
% yline(1.6336, 'r-')
% % xlim([0 10])
% ylim([-20 3])
xlabel('Confidence Level')
ylabel('Gamma')
title('Gamma vs Confidence Level')
legend('Robust Model', 'Markowitz Model')
subplot(3,1,2)
plot(confidence_levels, risk)
hold on 
% yline(48.1724, 'r-')
% ylim([0 5e-04])
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

% figure;
% plot(unc_set(1,:), unc_set(2,:), '*')

% figure;
% plot(confidence_levels, volume)


figure;
Ellipse_plot(W,c)




%% 
% variance = [0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01, 0.011, 0.012]
% 
% 
% 
% gamma = []; 
% risk = [];
% volume = [];
% 
% for i = 1:12
%     var = variance(i);
%     [W,c,e,Sigma, unc_set, assets] = callingfunc_real(1, 0.001);
%   
%     cvx_begin sdp quiet
%     
%     % Define variables
%     variable x(assets,1);,
%     variable a(1);
%     variable g(1);
%     
%         % Cost function
%         maximize(g);
%         % Constraints
%         subject to
%         %  Budget Constraint
%             e'*x == 1; 
%         %  Short Selling Constraint
%             for i=1:assets
%                 x(i)>=0;
%                 x(i)<=1;
%             end
%         %  Alpha Constraint
%             a>=0;
%         
%         %  Risk Constraint: x'*Sigma*x<=var
%            [var,x';x,inv(Sigma)]>=0
% 
%         %  LMI Constraint
%            [(a*c'*W*c)-a-g, 0.5*x'-a*c'*W; 0.5*x-a*W*c, a*W] >= 0
% 
% 
%     
%     cvx_end
% 
%     gamma(end+1) = g;
%     risk(end+1) = x'*Sigma*x;
%     if assets == 3
%         volume(end+1) = ellipse_volume(W);
%     end
% end
% 
% 
% figure;
% plot(variance, gamma)
% 
% 
