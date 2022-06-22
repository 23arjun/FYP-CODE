function [radius, center] = confidence_func_ball(unc_set, tolerance, confidence)
    
    [radius , center] = MinVolBall(unc_set, tolerance);
           
    [assets, num_points] = size(unc_set);

    %using ellipsoid algorithm (without confidence)
    if(confidence ~= 1)

        len = [];
        [assets, num_points] = size(unc_set);
        remove = round((1-confidence)*num_points);
        
        
        [radius, center] = MinVolBall(unc_set, 0.01);
        
        for i = 1:num_points
        
            xi = unc_set(:,i);
            length = (xi-center)'*(xi-center);
            len(end+1) = length; 
        
        end
        
        unc_set_len = [unc_set;len]
        
        [temp, order] = sort(unc_set_len(assets+1,:));
        reduced_set = unc_set_len(:,order);
        reduced_set = reduced_set(:,1:end-remove)
        size(reduced_set)
        reduced_set(end,:) = []
        
        
        
        [radius, center] = MinVolBall(reduced_set, 0.01);



    end
    

