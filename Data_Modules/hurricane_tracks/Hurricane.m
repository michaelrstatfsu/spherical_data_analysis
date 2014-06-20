%% Download the Hurricane data first.
% navigate to http://www.ncdc.noaa.gov/ibtracs/index.php?name=wmo-data and
% download the zipped 'All storms (2 MB)' csv file then unzip it in the
% working directory for before running this script.
%%
clear; close all;

if exist('Hurricane_Tracks.mat','file')
    load Hurricane_Tracks.mat
else
    creat_hurricane_Tracks
    load Hurricane_Tracks.mat
end

%% Specify hurricane type
% Basins'NA' 'SA' 'EP' 'WP' 'SP' 'NI' 'SI'
IndexNA = strfind(Basin, 'NA');IndexNA=~cellfun(@isempty,IndexNA);
Index1= (WindWMO>64).*(WindWMO<=82);% Category 1
Index2= (WindWMO>82).*(WindWMO<=95);% Category 2
Index3= (WindWMO>95).*(WindWMO<=112);% Category 3
Index4= (WindWMO>112).*(WindWMO<=136);% Category 4
Index5= (WindWMO>136);% Category 5
IndexYear = (Season>=2010).*(Season<2013); % Specify Years (1848-2013)
%% Populated Hurricane list
IND=find((IndexNA.*Index3.*IndexYear)~=0); % find hurricanes in north atlantic basin at reaching least category 3 between the selected years
STORMS=unique(Serial_Num(IND));
S=length(STORMS);
display(['There are ' num2str(S) ' storms selected.'])

%%
close all
figure
globe([],'earth_1600.jpg');hold on;
INDEX=1:S;
for i=INDEX
Index = strfind(Serial_Num,STORMS{i});
Index =find(~cellfun(@isempty,Index));
display([Name{Index(1)} ' ' ISO_time{Index(1)} ' to ' ISO_time{Index(end)}])
t0=zeros(1,length(Index));
for j=1:length(Index)
    t0(j) = datenum(ISO_time{Index(j)});
end
lat=Latitude(Index);
lon=Longitude(Index);
azimuth=pi*lon/180;
elevation=pi*lat/180;
[x,y,z]=sph2cart(azimuth,elevation,1);
wind=WindWMO(Index);
%     pres=interp1(t0,PresWMO(Index),t);
X=[x,y,z]';
hold on
plot3(X(1,:),X(2,:),X(3,:),'y','linewidth',2);
scatter3(X(1,:),X(2,:),X(3,:),wind,'r');
%     scatter3(X(1,:),X(2,:),X(3,:),pres,'r');

end
view(mean(X,2));
zoom(2)