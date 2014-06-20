
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

