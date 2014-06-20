clear; close all; 
%% Specify which bird data set you wish to use
% load  Pintail_data.mat;
load Swainson_Hawks_data.mat;
% load Turkey_Volture_data.mat;
% load  Brant_Geese_data.mat;
%% Overview data
Z=Overall_Preview(ID,date,location);
figure;earth;hold on;
%cloud %if you want clouds
scatter3(Z(1,:),Z(2,:),Z(3,:),10,'y')
view(mean(Z,2)/norm(mean(Z,2)));zoom(2)
%% Which Bird?
birdnumber=10;
%% All data avaiable for that bird
[z,bird_date]=individual_birdpath(ID,date,location,birdnumber);
%% Plot all available observations
figure
earth;hold on;
%cloud %if you want clouds
scatter3(z(1,:),z(2,:),z(3,:),20,'y','fill')
plot3(z(1,:),z(2,:),z(3,:),'r');view(mean(z(:,:),2)/norm(mean(z(:,:),2)));zoom(2)
%% Specify a time interval
ti=[bird_date(1)+10,bird_date(1)+30]; % day 10 to day 30
[z,bird_date]=individual_birdpath(ID,date,location,birdnumber,ti);
% Resample Observations using interpolation
% binsize=mean(diff(bird_date));
%  binsize=7; % weekly
% binsize=1; % daily
% binsize=1/24; % hourly
% binsize=1/60; % minute
binsize=1/1200; % seconds
z=my_interpolation(z,bird_date,bird_date(1):binsize:bird_date(end));
%% Plot Observations
% close all; figure
earth('Topo_HighRes.jpg');hold on; % HIGHER RESOLUTION EARTH IMAGE
% earth('Topo_SuperRes.jpg');hold on; % SUPER HIGH RESOLUTION EARTH IMAGE (SLOW)
%cloud %if you want clouds
scatter3(z(1,:),z(2,:),z(3,:),20,'y','fill')
plot3(z(1,:),z(2,:),z(3,:),'r');view(mean(z(:,:),2)/norm(mean(z(:,:),2)));zoom(20)

