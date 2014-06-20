function [X,Y,Z]=s2c(theta,phi)
X=sin(theta).*cos(phi); 
Y=sin(theta).*sin(phi); 
Z=cos(theta);
end