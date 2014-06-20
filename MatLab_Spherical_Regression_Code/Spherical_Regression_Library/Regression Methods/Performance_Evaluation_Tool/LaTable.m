function [] = LaTable(label,Matrix,N)
R=length(label.row);
C=length(label.col);
%
format='%4.1f';%4;
starter{1}=['&${'];
starter{2}=['&${\\bf '];
ender{2}=['}$'];
display([' '])
str='\\begin{tabular}{|c|';
str=[str, repmat('c',1,C), '|}\n'];
str=[str,'\\hline\n'];
if exist('N','var')
    str=[str '$n=' num2str(N) '$'];
end
for c=1:C
    str=[str '&' strrep(label.col{c},'\','\\')];
end
str=[str, '\\\\\n'];
str=[str,'\\hline\n'];

for r=1:2
    X=Matrix(r,:);
    if min(X)==0
        dec=0;
    else
        dec=floor(log10(min(abs(X(X~=-Inf)))));dec=dec-(dec==1);
    end
    ender{1}=['\\times 10^{' num2str(dec) '}}$'];
    [~,i]=max(X); %[~,i]=min(X);   
    str=[str strrep(label.row{r},'\','\\')];
    
    for c=1:C
        str = [str starter{1+(i==c)} num2str(X(c)*10^-dec,format) ender{1+(dec==0)}];
    end
    str=[str, '\\\\\n'];
    str=[str,'\\hline\n'];
end
%%

str=[str,'\\end{tabular}\n'];



fprintf(str)
display([' '])
end

