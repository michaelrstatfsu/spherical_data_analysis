clear; close all; 
%% Specify which bird data set you wish to use
% load  Pintail_data.mat;
% load Swainson_Hawks_data.mat;
load Turkey_Volture_data.mat;
% load  Brant_Geese_data.mat;
%% Overview data
Z=Overall_Preview(ID,date,location);
figure;globe([],'earth_1600.jpg');hold on;
%cloud %if you want clouds
scatter3(Z(1,:),Z(2,:),Z(3,:),10,'y')
view(mean(Z,2)/norm(mean(Z,2)));zoom(2)
%% Which Bird?
birdnumber=1;
%% All data avaiable for that bird
z=individual_birdpath(ID,date,location,birdnumber);
%% Plot all available observations
figure
earth;hold on;
% cloud %if you want clouds
scatter3(z(1,:),z(2,:),z(3,:),20,'y','fill')
plot3(z(1,:),z(2,:),z(3,:),'r');view(mean(z(:,:),2)/norm(mean(z(:,:),2)));zoom(2)
%% Specify a time interval
% ti=[datenum('14-Sep-2004 14:00:00'),datenum('14-Sep-2005 14:00:00')]; % first year
ti=[datenum('14-Sep-2004 14:00:00'),datenum('14-Sep-2004 14:00:00')+180]; % first 180 days
z=individual_birdpath(ID,date,location,birdnumber,ti);
%% Plot Observations
figure
earth;hold on;
%cloud %if you want clouds
scatter3(z(1,:),z(2,:),z(3,:),20,'y','fill')
plot3(z(1,:),z(2,:),z(3,:),'r');view(mean(z(:,:),2)/norm(mean(z(:,:),2)));zoom(2)

