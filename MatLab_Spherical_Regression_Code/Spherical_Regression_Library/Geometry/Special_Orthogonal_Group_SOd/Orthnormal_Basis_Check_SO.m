clear
d=10;
for i=1:100
A= SO_generator(d);
% A=eye(3);
E=Basis_T_SO(A);
ind= randsample(1:(d*(d-1)/2),2);
ortho(i)=trace(E(:,:,ind(1))'*E(:,:,ind(2)));
normal(i)=trace(E(:,:,ind(1))'*E(:,:,ind(1)));
tangent(i)=trace(inv(A)*E(:,:,ind(2)));
end
close all
subplot(3,1,1);plot(ortho);title('ortho')
subplot(3,1,2);plot(normal);title('normal')
subplot(3,1,3);plot(tangent);title('tangent')