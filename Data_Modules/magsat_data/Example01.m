clear;close all
load 'magsat_79_11_12_to_79_11_21.mat'
%% Plot data
r=6378;
r2=r+600;
[Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=sphere;
close all;
globe([],'earth_1600.jpg',r);hold on;
scatter3(r2*X(1,:),r2*X(2,:),r2*X(3,:),50,'r','fill'); 
quiver3(r2*X(1,:),r2*X(2,:),r2*X(3,:),Y(1,:),Y(2,:),Y(3,:),'r','linewidth',2);
%%
