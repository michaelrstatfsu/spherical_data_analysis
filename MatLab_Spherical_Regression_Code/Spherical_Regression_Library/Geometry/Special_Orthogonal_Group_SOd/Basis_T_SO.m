
%% Basis for the Tangent space at A in SO(d)
% This function constructs an orthonormal basis for the tangent space
% at A in the group of Special Orthogonal dXd Matrices.
%
% A should be a dXd orthogonal matrix with determinant 1. If no argument is provided,
% an orthonormal basis is constructed at the identity matrix.
%
% EA is a dxdx(d*(d-1)/2) double where the third component indexes the indivual
% Basis elements.
function [EA] = Basis_T_SO(A)
[d,~]=size(A);
ind=1;
M=zeros(d,d,d*(d-1)/2);
for i=1:d
    for j=(i+1):(d)
        M(i,j,ind)=1/sqrt(2);
        M(j,i,ind)=-1/sqrt(2);
        ind=ind+1;
    end
end
% keyboard
for k=1:(d*(d-1)/2)
    EA(:,:,k)=A*M(:,:,k);
end

end

