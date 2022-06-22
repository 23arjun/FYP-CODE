confidence_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
gamma = [];
risk = []
volume = [];
for i = 1:11
    confidence = confidence_levels(i);

    
    int_threshold = 0.3
    rng()
    [e1,c1, e2, c2 ,e, Sigma,var, unc_1, unc_2, assets, intersect] = calling_multipleellipse(confidence, 2, int_threshold);
    if intersect == false
        cvx_begin sdp quiet
            
            % Define variables
            variable x1(assets,1);
            variable g1(1);
            variable a1(1);
            
                % Cost function
                maximize(g1);
                % Constraints
                subject to
                %  Budget Constraint
                    e'*x1 == 1; 
                %  Short Selling Constraint
                    for i=1:assets
                        x1(i)>=0;
                        x1(i)<=1;
                    end
                %  Alpha Constraint
                    a1>=0;
                
                %  Risk Constraint: x'*Sigma*x<=var
                   [var,x1';x1,inv(Sigma)]>=0;
                
                %  LMI Constraint
                   [(a1*c1'*e1*c1)-a1-g1, 0.5*x1'-a1*c1'*e1; 0.5*x1-a1*e1*c1, a1*e1] >= 0;
         
         cvx_end
        
         cvx_begin sdp quiet
            
            % Define variables
            variable x2(assets,1);
            variable g2(1);
            variable a2(1);
            
                % Cost function
                maximize(g2);
                % Constraints
                subject to
                %  Budget Constraint
                    e'*x2 == 1; 
                %  Short Selling Constraint
                    for i=1:assets
                        x2fx(i)>=0;
                        x2(i)<=1;
                    end
                %  Alpha Constraint
                    a2>=0;
                
                %  Risk Constraint: x'*Sigma*x<=var
                   [var,x2';x2,inv(Sigma)]>=0;
                
                %  LMI Constraint
                   [(a2*c2'*e2*c2)-a2-g2, 0.5*x2'-a2*c2'*e2; 0.5*x2-a2*e2*c2, a2*e2] >= 0;
         
         cvx_end
        x2;
%         g = min([g1 g2]);
        if g1 < g2
            g = g1;
            x = x1;
            e = e1;
            c = c2
        else 
            g = g2;
            x = x2;
            e = e2
            c = c2
        end
    vol = ellipse_volume(e1) + ellipse_volume(e2)

    else
         [W,c,e,Sigma, assets] = callingfunc_real(confidence, 0.001);
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
                
                %  Risk Constraint: x'*Sigma*x<=var
                   [var,x';x,inv(Sigma)]>=0;
                
                %  LMI Constraint
                   [(a*c'*e*c)-a-g, 0.*x'-a*c'*e; 0.5*x-a*e*c, a*e] >= 0;
         
         cvx_end
         vol = ellipse_volume(e)
    end
    gamma(end+1) = g;
    risk(end+1) = x'*Sigma*x
    volume(end+1) = vol
end


figure;
subplot(3,1,1)
plot(confidence_levels, gamma)
hold on
% yline(1.6336, 'r-')
 
% ylim([-15 2])
% % xlim([0 10])
% ylim([-0.02 0.05])
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
% legend('Robust Model', 'Markowitz Model')
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

figure;
Ellipse_plot(e1,c1)
hold on
Ellipse_plot(e2,c2)
hold on
plot3(unc_1(1,:), unc_1(2,:), unc_1(3,:), '*')
hold on
plot3(unc_2(1,:), unc_2(2,:), unc_2(3,:),'*')

