% run this to see the current progress of the 
clear; close all;

kap=[5,10,50,100,500,1000]
fprintf(['\\begin{tabular}{ccccc}\n'])
fprintf(['n&$\\kappa$&$\\hat{p}$&$\\tilde{p}$&$p^*$\\\\\\hline \n'])
for k=1:length(kap)
    load(['Shape_Recognition_' num2str(kap(k))])
    rate(:,k)=[mean(c1(1:i)==c0(1:i))
    mean(c2(1:i)==c0(1:i))
    mean(c3(1:i)==c0(1:i))];
fprintf([num2str(i) '&'  num2str(kap(k)) '&' num2str(rate(1,k)) '&' num2str(rate(2,k)) '&' num2str(rate(3,k)) '\\\\ \n'])
end
figure
fprintf('\\end{tabular}\n')
% plot(kap,rate')
% xlabel('Concentration')
plot(log(kap),rate')
xlabel('Log Concentration')
legend('PLT','LLR','RRR')


%%
fprintf(['\\begin{tabular}{cccc}\n'])
fprintf(['$\\kappa$&$\\hat{p}$&$\\tilde{p}$&$p^*$\\\\\\hline \n'])
for k=1:length(kap)
    load(['Shape_Recognition_' num2str(kap(k))])
    rate(:,k)=[mean(c1(1:i)==c0(1:i))
    mean(c2(1:i)==c0(1:i))
    mean(c3(1:i)==c0(1:i))];
fprintf([ num2str(kap(k)) '&' num2str(rate(1,k)) '&' num2str(rate(2,k)) '&' num2str(rate(3,k)) '\\\\ \n'])
end
fprintf('\\end{tabular}\n')
