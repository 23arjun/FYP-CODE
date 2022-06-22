function [A, b, V, k, reduced_set, vol] = confidence_polytope_facet(unc_set, confidence)
    
    [k vol] = convhulln(unc_set,{'Qt', 'Qx'});
    C = unique(k); 
    V = unc_set(C,:);
    [A,b] = vert2lcon(V);

%     W=unc_set(k,:);
%     V=W(1:end-1,:);
%     A=(W(2:end,:)-V)*[0 -1; 1 0]
%     b=dot(A,V,2)

    [num_points, assets] = size(unc_set);
     reduced_set = unc_set;


    if(confidence ~= 1)

        Ax = [];
        [num_points, assets] = size(unc_set);
        remove = round((1-confidence)*num_points);
        
        
%         [radius, center] = MinVolBall(unc_set, 0.01);
        
        for i = 1:num_points
        
            xi = unc_set(i,:);
            magAx = norm(A*xi');
            Ax(end+1,:) = magAx; 
        
        end
        
        unc_set_Ax = [unc_set, Ax];
        [temp, order] = sort(unc_set_Ax(:,assets+1));
        reduced_set = unc_set_Ax(order,:);
        reduced_set = reduced_set(1:end-remove,:);
        size(reduced_set);
        reduced_set(:,end) = [];
        size(reduced_set);

        [k vol] = convhulln(reduced_set,{'Qt', 'Qx'});
        C = unique(k);
        V = reduced_set(C,:);
        [A,b] = vert2lcon(V);

    end

% 
% plot(unc_set(:,1),unc_set(:,2),'*')
% hold on
% plot(reduced_set(:,1),reduced_set(:,2),'*')
% hold on
% plot(reduced_set(k,1),reduced_set(k,2))

