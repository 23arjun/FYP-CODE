function [ellipse, center] = confidence_func(unc_set, confidence, tolerance)
    tolerance = 0.01;
    [ellipse , center] = MinVolEllipse(unc_set, tolerance);
    [assets, num_points] = size(unc_set);
   
    if(confidence ~= 1)
        count = 0;
        
        remove = round((1-confidence)*num_points);
        x_copy = unc_set;
        
        
        while count < remove
        
           [rows,cols] = size(x_copy);
           i = 1;
              
            while i < cols
            
                xi = x_copy(:,i);
            
               
                if (xi-center)'*ellipse*(xi-center) >=1
                  
                    x_copy(:,i) = [];
                    count = count+1;
                    [rows,cols] = size(x_copy);
                end
            
                i = i+1;
            
            end
                

            
           [ellipse , center] = MinVolEllipse(x_copy, tolerance);
     
        
        end
    end