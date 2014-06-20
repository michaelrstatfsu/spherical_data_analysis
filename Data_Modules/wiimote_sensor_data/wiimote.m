%% Collecting wiimote data
% To collect data from wiimote sensors you will need the following.
%
% (1) a computer with bluetooth enabled
%
% (2) the python packages 'cwiid' and 'time' installed
%
% (3) two wiimotes
%
% Run the 'wiireader.py' script and syncronize the left and right wiimote
% when prompted. For some wiimotes, the pressing 1 and 2 together will not
% work because syc button is conviently located inside inside the battery
% case. Once the wiimotes are synced the script will prompt the user to get
% ready to perform the action. A counter will display numbers 1 through 100
% which indicating the recorded time steps. One can easily adjust the
% number of steps and the time separation by modifying the last while loop
% of the python script.

system('python wiireader.py')
%%
clear;
WM1 = importdata('wm1data');WM1=WM1(2:end,:)
WM2 = importdata('wm2data');WM2=WM2(2:end,:)

theta=pi*abs(WM1(:,2)-100)/(151-100);
sign=1-2*(WM1(:,1)>=WM1(:,3));
phi=pi*sign.*abs(WM1(:,1)-100)/(151-100);


theta2=pi*abs(WM2(:,2)-100)/(151-100);
sign=1-2*(WM2(:,1)>=WM2(:,3));
phi2=pi*sign.*abs(WM2(:,1)-100)/(151-100);

[X(1,:),X(2,:),X(3,:)]=s2c(theta,phi);
[Y(1,:),Y(2,:),Y(3,:)]=s2c(theta2,phi2);
r=1.02;X=r*X;Y=r*Y;
close all; sphere;colormap(gray);axis equal;set(gca,'linewidth',2,'fontsize',20)
hold on;scatter3(X(1,:),X(2,:),X(3,:),100,'fill','y');
hold on;scatter3(X(1,:),X(2,:),X(3,:),100,'black','linewidth',2);
view(mean([X,Y],2))
print('-dpng','wii_left.png')

figure;
sphere;colormap(gray);axis equal;set(gca,'linewidth',2,'fontsize',20)
hold on;scatter3(Y(1,:),Y(2,:),Y(3,:),100,'fill','r');
hold on;scatter3(Y(1,:),Y(2,:),Y(3,:),100,'black','linewidth',2);
view(mean([X,Y],2))
print('-dpng','wii_right.png')
%%
figure;plot(WM1,'linewidth',2);
ylim([90,160])
set(gca,'linewidth',2,'fontsize',18);
print('-dpng',['wiimoterawleft.png'])
figure;plot(WM2,'linewidth',2);
ylim([90,160])
set(gca,'linewidth',2,'fontsize',18);
print('-dpng',['wiimoterawright.png'])
%%

% save inward45.mat X Y