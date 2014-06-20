%% Compute Residuals
%[Z] = center([Yhat],[Y]); % Compute  Residuals of training data
[Z] = center([Yhat2],[Y2]); % Compute  Residuals of testing data
%[Z] = center([Yhat,Yhat2],[Y,Y2]); % Compute  Residuals of all data
[~,NZ]=size(Z);
%% Diagnostic Statistics
MSE_train(index)=2-2*trace(Yhat'*Y)/N; % Train MSE
MSE_test(index)=2-2*trace(Yhat2'*Y2)/N2; % Test MSE
roughness(index)=R_1(GAM_id,GAM); % Compute Roughness
kappahat(index)=kappa_tilde(Z); % Compute MSE of Kappa
[W(index),pvalue(index)]=vmf_fb_lrt_3(Z); % computes likelihood ratio test statistic and pvalue
r=2*kappahat(index)*(1-Z'*north); % this statistic should follow a chisq distribution with df=2
%% Plots

close all

figure
h=surf(GAM(:,:,1)',GAM(:,:,2)',GAM(:,:,3)',...
    'EdgeColor','black','linewidth',lw);
colormap(.8*gray)
hold on;PLOT(Yhat2,argYhat);PLOT(Y2,argY);PAIR(Yhat2,Y2);
zoom(1);view(mean([X,Y]'))
title([model ' Observer VS Predicted'])
if exist('figtype','var')
    print(figtype,[filename '_pred_' model figext]);
end
% shows the deformed grid with the observed and predicted response values
% plotted


figure
sphere;colormap(.7*gray);hold on
PLOT(Z)
view([0,0,1]')
title([model ' Residuals'])
if exist('figtype','var')
    print(figtype,[filename '_res_' model figext]);
end
% residuals should be isotropic about the mean

figure
hist(r,10);hold on
xlim([min(r),max(r)])
t=linspace(0,max(r),100);
plot(t,NZ*chi2pdf(t,M-1),'g','linewidth',3)
set(gca,'linewidth',2,'fontsize',18)
title([model ' Histogram'])
if exist('figtype','var')
    print(figtype,[filename '_hist_' model figext]);
end
% Histogram should resemble a chisqrt distribution with df=2;