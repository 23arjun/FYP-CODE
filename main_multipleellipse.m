gamma = []
risk = []
volume = []
confidence_levels = [ 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 1];
for i = 1:11
    int_threshold = 0.3
    confidence = confidence_levels(i);
    [e1,c1, e2, c2 ,e, Sigma,var, unc_1, unc_2, assets, intersect] = calling_multipleellipse(3, 200, confidence, 2, int_threshold)
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
            
            %  Risk Constraint: x'*Sigma*x<=s
%                [var,x1';x1,inv(Sigma)]>=0;
            
            %  LMI Constraint
               [(a1*c1'*e1*c1)-a1-g1, 0.5*x1'-a1*c1'*e1; 0.5*x1-a1*e1*c1, a1*e1] >=0;
            
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
                    x2(i)>=0;
                    x2(i)<=1;
                end
            %  Alpha Constraint
                a2>=0;
            
            %  Risk Constraint: x'*Sigma*x<=s
%                [var,x2';x2,inv(Sigma)]>=0;
            
            %  LMI Constraint
               [(a2*c2'*e2*c2)-a2-g2, 0.5*x2'-a2*c2'*e2; 0.5*x2-a2*e2*c2, a2*e2] >=0;
        
        cvx_end
        
        if g1 < g2
            g = g1;
            x = x1;
%             e = e1;
        else 
            g = g2;
            x = x2;
%             e = e2;
        end

        vol = ellipse_volume(e1) + ellipse_volume(e2)
        
     else
         [W,c,e,Sigma, unc_set, assets] = callingfunc_synthetic(3,200, confidence, var);
    
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
%                [var,x';x,inv(Sigma)]>=0;
            
            %  LMI Constraint
               [(a*c'*W*c)-a-g, 0.5*x'-a*c'*W; 0.5*x-a*W*c, a*W] >=0;
            
        cvx_end
        vol = ellipse_volume(e)
        
    end

  volume(end+1) =  vol;
  risk(end+1) = x'*Sigma*x
  gamma(end+1) = g

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


