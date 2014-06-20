% Simulate data iid
d=4; %dimension
n=100; %sample size
kappa=10; %specify true kappa
mu=zeros(d,1);mu(d)=1;%specify true mean direction
Z=randvonMisesFisherm(d, n, kappa, mu);
% Estimate kappa
kappa_tilde(Z)
%%
% Simulate data regression setting
MU=Z;
kappa_y=100;
for i=1:n
Y(:,i)= randvonMisesFisherm(d, 1, kappa_y, MU(:,i));
end
% Estimate kappa
kappa_tilde(MU,Y)