clear;close all
%% Download this month's data and extract it
% monthly-upd  Files of monthly means for the last month only (replaced monthly)
% IV. Format of IGRA Monthly-Mean Files
%
% ---------------------------------
% Notes:
% ---------------------------------
%
% 1. File names are of the form VVVV_HHz.mly, where VVVV = variable and HH =
%    nominal hour.
%    Possible values for VVVV: ghgt = geopotential height, temp = temperature,
%      uwnd = zonal wind component, vwnd = meridional wind component.
%
%    Possible values for   HH: 00, 12.
%
% 2. Monthly means are computed for the surface and mandatory levels at the
%    nominal times of 00 and 12 UTC, considering data within two hours of each
%    nominal time.
%
% 3. A mean is provided only if there are at least 10 values for a particular
%    station, month, nominal time, and level.
%
% 4. Means are given in units of meters for geopotential height, degrees C * 10
%    for temperature, and (m/s) * 10 for zonal and meridional wind.
%
%
% ---------------------------
% File Format (VVVV_HHz.mly):
% ---------------------------
%
%   Variable Name             Columns  Description
%   ------------------------  -------  -----------
%
%   Station Number              1-  5  WMO station number
%
%   Year                        7- 10
%
%   Month                      12- 13
%
%   Pressure Level             15- 18  units of HPa (mb), 9999 = Surface level
%
%   Mean Value                 20- 24  see Note 4 above for units
%
%   Number of Values in Mean   26- 27

% Linux script
% system('wget -r -nd --no-parent --reject "index.html*" http://www1.ncdc.noaa.gov/pub/data/igra/monthly-upd/')
%% Decompress data into readable format

% Linux Script
%  system('sudo apt-get install gunzip') % debian linux 
%  system('gunzip *.gz') % debian linux 
%% Download the format information files
% igra-composites.txt            IGRA stations with composited records
% igra-countries.txt             List of country codes used in the station list
% igra-metadata20090527.txt      IGRA station history and metadata inventory
% igra-metadata-description.txt  Description and format of igra-metadata.txt
% igra-qc.pdf                    Paper describing IGRA quality-control
%                                for temperature (J. Climate, in press)
% igra-overview.pdf              Paper describing IGRA (J. Climate, 2006)
% igra-stations.txt              List of stations in IGRA
% readme.txt
% status.txt                     Notes on the current status of IGRA's
%                                online files

% Linux Script
%system('wget -r -np -nd -l1 --reject "index.html*" http://www1.ncdc.noaa.gov/pub/data/igra/')
%% Import Wind Velocities
clear
filename = 'vwnd_12z.mly.201312';
formatSpec = '%5f%5f%3f%5f%6f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
% Allocate imported array to column variable names
StationNumber = dataArray{:, 1};
%Year = dataArray{:, 2};
%Month = dataArray{:, 3};
%PressureLevel = dataArray{:, 4}; %(mb)
vwnd = dataArray{:, 5}; %(10*m/s)
%NumberofValuesinMean = dataArray{:, 6};
% Clear temporary variables
clearvars filename formatSpec fileID dataArray ans;
%
filename = 'uwnd_12z.mly.201312';
formatSpec = '%5f%5f%3f%5f%6f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
uwnd = dataArray{:, 5}; %(10*m/s)
pressure=dataArray{:, 4};
clearvars filename formatSpec fileID dataArray ans;
%% Load station list data
filename = 'igra-stations.txt';
formatSpec = '%*2s%7f%38s%6f%8f%5f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '',  'ReturnOnError', false);
fclose(fileID);
StationNumber_list = dataArray{:, 1};
StationName_list = dataArray{:, 2};
Latitude_list= dataArray{:, 3};
Longitude_list = dataArray{:, 4};
Elevation_list = dataArray{:, 5}; % in meters
clearvars filename formatSpec fileID dataArray ans;
%% Append Georaphical location
N=length(StationNumber);
N_list=length(StationNumber_list);
for i=1:N_list
    IND=find(StationNumber==StationNumber_list(i));
    lat(IND,1)=Latitude_list(i);
    lon(IND,1)=Longitude_list(i);
end
%%
save balloon_data lat lon uwnd vwnd StationNumber pressure
%%
clear;load balloon_data.mat
close all;quiver(lon,lat,uwnd,vwnd)
axis equal
print -dpng radiosonde.png

