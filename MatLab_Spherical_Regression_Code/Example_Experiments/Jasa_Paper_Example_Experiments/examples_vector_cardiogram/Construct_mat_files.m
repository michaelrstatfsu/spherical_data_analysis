%% Select subgroup
% to Select a group, uncomment it and comment all the other groups.
%clear 
% load rawvectorcardiogram
% group=AgeSex==1;filename='boys_2_10';% boys_2_10 n=28
% group=AgeSex==2;filename='boys_11_19';% boys_11_19 n=28
% group=AgeSex==3;filename='girls_2_10';% girls_2_10 n=17
% group=AgeSex==4;filename='girls_11_19';% girls_11_19 n=25
% group=(AgeSex==1)|(AgeSex==2);filename='boys_2_19';% boys_2_19 n=56
% group=(AgeSex==3)|(AgeSex==4);filename='girls_2_19';% girls_2_19 n=42
% group=(AgeSex==1)|(AgeSex==3);filename='Age_2_10';% Age_2_10 n=45
% group=(AgeSex==2)|(AgeSex==4);filename='Age_11_19';% Age_11_19 n=53
% group=logical(ones(1,98));filename='All';% All n=98
%% Greatest Direction of QRS loops
x=[FQRS1(group),FQRS2(group),FQRS3(group)]';
y=[MQRS1(group),MQRS2(group),MQRS3(group)]';


X=x;Y=y; % uncomment to select

% close all;globe([],'');hold on
% PLOT(x);PLOT(y);view(mean([x,y],2))
%% Unit vector perpendicular to QRS plane
x=[FPRP1(group),FPRP2(group),FPRP3(group)]';
y=[MPRP1(group),MPRP2(group),MPRP3(group)]';

% X=x; Y=y;% uncomment to select

% close all;globe([],'');hold on
% PLOT(x);PLOT(y);view(mean([x,y],2))
%% Greatest Direction of T loops
x=[FT1(group),FT2(group),FT3(group)]';
y=[MT1(group),MT2(group),MT3(group)]';

% X=x;Y=y;% uncomment to select

% close all;globe([],'');hold on
% PLOT(x);PLOT(y);view(mean([x,y],2))
%%
save(['Vector_Cardiogram_' filename '.mat'],'X','Y')