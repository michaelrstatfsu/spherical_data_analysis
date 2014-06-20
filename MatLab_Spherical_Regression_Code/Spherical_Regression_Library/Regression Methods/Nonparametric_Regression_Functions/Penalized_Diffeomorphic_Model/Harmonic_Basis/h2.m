function [v]=h2(Theta,Phi);
    v(1,:,:)=-(sign(sin(Theta))).*sin(Phi); 
    v(2,:,:)=(sign(sin(Theta))).*cos(Phi);
    v(3,:,:)=0;
end
