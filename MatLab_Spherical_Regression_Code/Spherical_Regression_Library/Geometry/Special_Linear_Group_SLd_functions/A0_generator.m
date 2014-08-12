%% Generates a random $A_0\in SL(d)$
% d should be an a positive integer greater than 1. This specifies the size of the sqare matrix.
function A0=A0_generator(d)
%% if dimension d is not specified, set default d=3
if ~exist('d','var')
    d=3
end
%% construct orthonormal basis at the identity $I$
E= Basis_T_SL(eye(d));
%load T_I_SL_3.mat
%% Randomly generate coeficients of this $d^2-1$ basis elements
v=normrnd(0,1/2,d^2-1,1);
%% Compute $V\in T_I(SL(d))$ from the coefficients
V=zeros(d,d);
for i=1:(d^2-1)
    V=V+v(i).*E(:,:,i);
end 
%% Use the retraction mapping to map back to $SL(d)$
A0=expm(V);
end
