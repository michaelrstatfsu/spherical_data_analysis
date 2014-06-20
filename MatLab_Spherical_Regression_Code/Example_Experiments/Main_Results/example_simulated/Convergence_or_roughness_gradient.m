clear all;
load /home/michael/Documents/MATLAB/Verifying_first_order_roughness/Roughness_without_likelihood/RANDOM_DIFFEO_EXAMPLES/Diffeo_9.5194_60_15_510/Diffeo_9.5194_60_15_510.mat
%%
close all;
figure
SURF(Grid2(:,:,:,1),1.2)
zoom(1.5)
print('-dpng','convergencetorotation_highres_original')
figure
SURF(Grid2(:,:,:,end),1.2)
zoom(1.5)
print('-dpng','convergencetorotation_highres_final')
figure
plot(R_old);set(gca,'linewidth',2,'fontsize',20);
print('-dpng','convergencetorotation_highres_objective')
%%
clear all;
load /home/michael/Documents/MATLAB/Verifying_first_order_roughness/Roughness_without_likelihood/RANDOM_DIFFEO_EXAMPLES/Diffeo_7.1911_15_2_16/Diffeo_7.1911_15_2_16.mat
%%
close all;
figure
SURF(Grid2(:,:,:,1),1.2)
zoom(1.5)
print('-dpng','convergencetorotation_lowres_original')
figure
SURF(Grid2(:,:,:,end),1.2)
zoom(1.5)
print('-dpng','convergencetorotation_lowres_final')
figure
plot(R_old);set(gca,'linewidth',2,'fontsize',20);
print('-dpng','convergencetorotation_lowres_objective')
