function [] = LaTex_Table(Performance_Output)
O=Performance_Output;
N=O.N;
MSE= O.test.MSE;
kappa= O.test.kappa;
cvMSE= O.cv.MSE;
cvkappa= O.cv.kappa;
L=O.L;
l=O.l;
%%
% keyboard
%%
format='%4.1f';%4;
starter{1}=['&${'];
starter{2}=['&${\\bf '];
ender{2}=['}$'];
display([' '])
str='\\begin{tabular}{|c|cccc|}\n';
str=[str,'\\hline\n'];
str=[str '$n=' num2str(N) '$&PLT&LLR&RR&FPE\\\\\n'];
str=[str,'\\hline\n'];

% MSE
X=[MSE.PLT,MSE.LLR,MSE.RRR,MSE.BAR];
dec=floor(log10(min(X)));dec=dec-(dec==1);
ender{1}=['\\times 10^{' num2str(dec) '}}$'];
[~,i]=min(X);
str=[str 'MSE'];
for j=1:4
str = [str starter{1+(i==j)} num2str(X(j)*10^-dec,format) ender{1+(dec==0)}];
end
str=[str, '\\\\\n'];
str=[str,'\\hline\n'];
% keyboard

% kappa
X=[,kappa.PLT,kappa.LLR,kappa.RRR,kappa.BAR];
dec=floor(log10(min(X)));dec=dec-(dec==1);
ender{1}=['\\times 10^{' num2str(dec) '}}$'];
[~,i]=max(X);
str=[str '$\\hat{\\kappa}$'];
for j=1:4
str = [str starter{1+(i==j)} num2str(X(j)*10^-dec,format) ender{1+(dec==0)}];
end
str=[str, '\\\\\n'];
% str=[str,'\\hline\n'];

% cv kappa
X=[cvkappa.PLT,cvkappa.LLR,cvkappa.RRR,cvkappa.BAR];
dec=floor(log10(min(X)));dec=dec-(dec==1);
ender{1}=['\\times 10^{' num2str(dec) '}}$'];
[~,i]=max(X);
str=[str 'cv $\\hat{\\kappa}$'];
for j=1:4
str = [str starter{1+(i==j)} num2str(X(j)*10^-dec,format) ender{1+(dec==0)}];
end
str=[str, '\\\\\n'];
str=[str,'\\hline\n'];

% L
X=[l.PLT,l.LLR,l.RRR,l.BAR];
dec=floor(log10(min(X)));dec=dec-(dec==1);
ender{1}=['\\times 10^{' num2str(dec) '}}$'];
[~,i]=max(X);
str=[str '$\\log(\\mathcal{L})$'];
for j=1:4
str = [str starter{1+(i==j)} num2str(X(j)*10^-dec,format) ender{1+(dec==0)}];
end
str=[str, '\\\\\n'];
str=[str,'\\hline\n'];


% cvMSE
X=[cvMSE.PLT,cvMSE.LLR,cvMSE.RRR,cvMSE.BAR];
dec=floor(log10(min(X)));dec=dec-(dec==1);
ender{1}=['\\times 10^{' num2str(dec) '}}$'];
[~,i]=min(X);
str=[str 'cvMSE'];
for j=1:4
str = [str starter{1+(i==j)} num2str(X(j)*10^-dec,format) ender{1+(dec==0)}];
end
str=[str, '\\\\\n'];
str=[str,'\\hline\n'];

str=[str,'\\end{tabular}\n'];



fprintf(str)
display([' '])
end

