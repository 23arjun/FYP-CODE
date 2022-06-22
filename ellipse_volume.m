function [volume] = ellipse_volume(E)

B = (4/3)*pi;
volume = sqrt(det(inv(E)))*B