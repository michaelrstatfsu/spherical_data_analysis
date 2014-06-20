function [T,p_value] = vmf_fb_lrt3(x)
[p,n]=size(x);
if p~=3
    error('p must equal 3')
end
xbar=mean(x,2);
Rbar=sqrt(sum(xbar.^2));
xbar0=xbar/Rbar;
k=kappa_tilde(x);
H=rotMat(xbar0',[1,0,0]');
%%
% keyboard
%%
Y=H*x;y=Y(2:p,:);
l=svd(y*y'/n);
T=(n*(k^3)*(l(1)-l(2))^2)/(4*(k-3*Rbar));
p_value=chi2cdf(T,2,'upper');




end

