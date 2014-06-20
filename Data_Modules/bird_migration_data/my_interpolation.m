function z=my_interpolation(Z,t,time)
z(1,:)=interp1(t,Z(1,:),time);
z(2,:)=interp1(t,Z(2,:),time);
z(3,:)=interp1(t,Z(3,:),time);z=z./(ones(3,1)*sqrt(sum(z.^2))) ;
end