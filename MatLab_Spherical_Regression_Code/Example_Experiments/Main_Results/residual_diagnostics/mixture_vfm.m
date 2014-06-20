clear
filename='residual_diagnostics';
argX='400, ''y'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argY='400,''s'', ''r'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argYhat='400, ''g'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
argR='400, ''blue'',''fill'',''markeredgecolor'',''black'',''linewidth'',2 ';
lw=2;
lw2=1;
if ~exist('figtype','var')
    %     figtype='-depsc';figext='.eps';
    figtype='-dpng';figext='.png';
end

d=3;
n=100;
n1=floor(n/2);n2=n-n1;
kappa=100;
N=[zeros(d-1,1);1];
A=rotMat(N,randvonMisesFisherm(d,1,1000,N));
mu=A*N;
Z(:,1:n1)=randvonMisesFisherm(d,n1,kappa,N);
Z(:,(n1+1):n)=randvonMisesFisherm(d,n2,kappa,mu);


 close all
sphere;colormap(.7*gray);hold on; PLOT(Z,argR);view(N);
ins=1;[W(ins),p_value(ins)]=vMF_gof(Z,N)
