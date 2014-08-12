%% Randomly Generate a dXd Special Orthogonal Matrix
% 
% d denotes the number of rows and columns of the square 
% orthogonal matrix. If no argument is provided, d defualts
% to 3
function A0=SO_generator(d)
if ~exist('d','var')
    d=3
end
E= Basis_T_SO(eye(d));
%load T_I_SL_3.mat
v=normrnd(0,1/3,d*(d-1)/2,1);
A=zeros(d,d);
for i=1:(d*(d-1)/2)
    A=A+v(i).*E(:,:,i);
end
A0=expm(A);
end
