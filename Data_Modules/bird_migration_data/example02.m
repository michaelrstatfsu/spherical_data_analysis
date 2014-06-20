clear; close all; 
%% Specify which bird data set you wish to use
% load  Pintail_data.mat;
% load Swainson_Hawks_data.mat;
load Turkey_Volture_data.mat;
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
% ti=[bird_date(1),bird_date(1)+365]; % first year
ti=[bird_date(end)-180,bird_date(end)]; % last 180 days
z=individual_birdpath(ID,date,location,birdnumber,ti);
%% Plot Observations
figure
earth;hold on;
%cloud %if you want clouds
scatter3(z(1,:),z(2,:),z(3,:),20,'y','fill')
plot3(z(1,:),z(2,:),z(3,:),'r');view(mean(z(:,:),2)/norm(mean(z(:,:),2)));zoom(2)

