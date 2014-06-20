function [v]=h1(Theta,Phi);
    v(1,:,:)=cos(Theta).*cos(Phi); 
    v(2,:,:)=cos(Theta).*sin(Phi);
    v(3,:,:)=-sin(Theta);
end