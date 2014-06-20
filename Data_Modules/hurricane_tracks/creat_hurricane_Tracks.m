% For documentation see:
% http://www.ncdc.noaa.gov/ibtracs/index.php?name=wmo-data
% ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r05/wmo/csv/
clear;
filename = 'Allstorms.ibtracs_wmo.v03r05.csv';
url=['ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r05/wmo/csv/' filename '.gz'];

if ~exist(filename, 'file')
% if you run a debian linux system and have gunzip and wget installed
% you can automatically download and unzip the file with the following script.
% system(['wget ' url]);
% system(['gunzip ' filename '.gz'])
end
%% Check that the file has been downloaded and unzipped
if ~exist(filename,'file')
    sprintf(['Download and unzip the following file before running script:\n' url])
    break
else     
    [Serial_Num,Season,Num,Basin,Sub_basin,Name,ISO_time,Nature,Latitude,Longitude,WindWMO,PresWMO,Center1,WindWMOPercentile,PresWMOPercentile,Track_type] = import_hurricane(filename);
    clear filename
    %%
    save Hurricane_Tracks.mat
end

%%