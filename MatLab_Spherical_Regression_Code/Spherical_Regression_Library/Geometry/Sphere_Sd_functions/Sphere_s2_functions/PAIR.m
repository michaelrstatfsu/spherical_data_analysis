function [ output_args ] = PAIR(X,Y,r,col)
[M,N]=size(X);
hold on

K=15;
if ~exist('r','var')
    r=1.04;
end
if ~exist('col','var')
    col=[.9,.9,.9]';
end
for n=1:N
    x=linspace(X(1,n),Y(1,n),K)';
    y=linspace(X(2,n),Y(2,n),K)';
    z=linspace(X(3,n),Y(3,n),K)';
    Z=[x,y,z]';
    w=sqrt(sum((Z.^2)));
    plot3(r*x./w',r*y./w',r*z./w','color',col,'linewidth',3)
end

end

