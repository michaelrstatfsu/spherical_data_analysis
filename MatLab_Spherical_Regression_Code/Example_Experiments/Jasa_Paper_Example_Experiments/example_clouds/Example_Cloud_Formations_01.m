%% Cloud Formation Example 01
% This is a toy data set which Contains 29 data points sampled from 
% cloud formations for two consecutive days (Sembtember 4th and 5th 2012).
clear; close all;load Cloud_Example01.mat

%%
name1='clouds_9_04_12.jpg'; % Sembtember 4, 2012 cloudmap
name2='clouds_9_05_12.jpg'; % Sembtember 5, 2012 cloudmap
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
%% Evaluate the performance of models
[PO]=performance_evaluation(X,Y)
%% Output performance in as Late
LaTex_Table(PO)