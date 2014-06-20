function [W,p_value] = vmf_fb_lrt(x)
[p,n]=size(x);
xbar=mean(x,2);
Rbar=sqrt(sum(xbar.^2));
muhat=xbar/Rbar;
T=x*x'/n;
H=rotMat(muhat',[1,0,0]');
T_star=H'*T*H;
%
kappahat=kappa_tilde(x);
v1=(xbar(2:p,:).^2);
v2=((ones(p-1,1)*xbar(1,:)).*xbar(2:p,:));
v3=(xbar(2:(p-1),:).*xbar(3:(p),:));
ubar1=xbar';
ubar2=[v1',v2',v3'];
ubar=[ubar1,ubar2];

v=p/2-1;
Iv=besseli(v,kappahat,1);
Iv1=besseli(v+1,kappahat,1);
Iv2=besseli(v+2,kappahat,1);
Iv3=besseli(v+3,kappahat,1);
a1=Iv1/Iv;
a2=((p-1)*Iv2/p + Iv/p)/Iv;
b0=Iv1/(kappahat*Iv);
b1=Iv2/(kappahat*Iv);
b2=((p+1)*Iv3/(p+2) + Iv1/(p+2))/(kappahat*Iv);
d1=Iv2/(kappahat*kappahat*Iv);
d2=3*Iv2/(kappahat*kappahat*Iv);
a2_star=a2-a1*a1;
b1_star=b1-a1*b0;
d1_star=d1-b0*b0;
d2_star=d2-b0*b0;

f11= d2_star- b1_star*b1_star/a2_star;
f12= d1_star- b1_star*b1_star/a2_star;
g11=(f11+(p-3)*f12)/(2*d1*(f11+(p-2)*f12));
g12=-f12/(2*d1*(f11+(p-2)*f12));
g21=1/(b2-b1*b1/b0);
g31=1/d1;
% keyboard
%%
W=g11*sum((diag(T_star(2:p,2:p))-b0).^2);
W=W+g21*sum((T_star(1,2:p)).^2);
for j=2:(p-1)
    for k=(j+2):p
        W=W+2*g12*(T_star(j,j)-bo)*(T_star(k,k)-bo);
        W=W+2*g31*(T_star(j,k))*(T_star(j,k));
    end
end

p_value=chi2cdf(W,p*(p+1)/2-1,'upper');


end

