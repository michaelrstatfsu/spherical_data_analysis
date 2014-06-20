function [v]=h2b(Theta,Phi);
    v(1,:,:)=-sin(Phi); 
    v(2,:,:)=cos(Phi);
    v(3,:,:)=0;
end
