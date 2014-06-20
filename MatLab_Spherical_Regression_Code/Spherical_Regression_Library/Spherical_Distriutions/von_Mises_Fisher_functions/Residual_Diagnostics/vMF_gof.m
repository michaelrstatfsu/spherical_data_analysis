function [W,p_value] = vMF_gof(Z,xbar,kappahat)
[d,n]=size(Z);
if ~exist('xbar','var')
    xbar=mean(Z,2);xbar=xbar/norm(xbar);
end
if ~exist('kappahat','var')
    kappahat=kappa_tilde(Z);
end
% keyboard
r=2*kappahat*(1-Z'*xbar);
figure
hist(r,10);hold on
% keyboard
% [f,yi]=ksdensity(r,'support','positive');hold on
% plot(yi,n*f,'r','linewidth',3)
xlim([min(r),max(r)])
t=linspace(0,max(r),100);
plot(t,n*chi2pdf(t,d-1),'g','linewidth',3)
% keyboard
%%
if d==3
[W,p_value] = vmf_fb_lrt_3(Z);
else
[W,p_value] = vmf_fb_lrt(Z);
end
% R=sum(r);p_value2=chi2cdf(sum(r),n*(d-1),'upper');
end

