%% Cloud Formation Example 02
% This is a toy data set which Contains 44 data points sampled from 
% cloud formations for two consecutive days (August 29th and 30th 2012).
clear; close all;load Cloud_Example02.mat

%%
name1='clouds_8_29_12.jpg'; % August 29, 2012 cloudmap
name2='clouds_8_30_12.jpg'; % August 30, 2012 cloudmap
%%
figure(3);close;figure(3);
globe(X,'earth_1600.jpg');hold on; 
globe_layer([name1],.99);
center=mean(X,2); center= center/norm(center);
view(center);zoom(3);

figure(4);close;figure(4);
globe(Y,'earth_1600.jpg');hold on; 
globe_layer([name2],.99);hold on;
center=mean(Y,2); center= center/norm(center);
view(center);zoom(3);
grid off
%%
[PO]=performance_evaluation(X,Y)
%%
LaTex_Table(PO)