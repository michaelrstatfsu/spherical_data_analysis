%%
% This script will automaticall download and collect data from the
% magsat site  http://omniweb.gsfc.nasa.gov/ftpbrowser/ and combine it into
% one Matlab data set. It is suggested that you download the data files
% first before running this code.
% the magload function handles to loading of the individual .dat files. It
% converts relavent parts into cartesian coordinates for X (geographical
% coordinate) and Y (direction of Magnetic forces). Additionally the time
% coordinate T is stored in matlab time format. 
% the command [ x,y,t ] = magload( filename ,n) will randomly sample n
% observations from the specified dat file and output it geographical
% coordinates, direction of magnetic force, and time.


clear;close all
URL='ftp://spdf.gsfc.nasa.gov/pub/data/magsat/'
%% Download Documentation Files
if ~exist('00readme.txt','file')
    display(['Download files from:' URL])
    urlwrite([URL '00readme.txt'],'00readme.txt')    
end
if ~exist('magsat.txt','file')
    display(['Download files from:' URL])
    urlwrite([URL 'magsat.txt'],'magsat.txt')    
end

%%
n=15; %Sample size from each day
Ye=79;Mo=11;Da=12;
DateNumber = datenum(Ye,Mo,Da);FORMAT='%.2d';
c=datevec(DateNumber);Ye=c(1);Mo=c(2);Da=c(3);
f1=[num2str(Ye,FORMAT) '_' num2str(Mo,FORMAT) '_' num2str(Da,FORMAT)]
filename=[f1 '.dat']
if exist(filename,'file')
    [x,y,t]=magload(filename,n);
else
    display(['Download files from:' URL filename])
    urlwrite([URL filename],filename)    
    [x,y,t]=magload(filename,n);
end
X=[x];Y=[y];T=[datenum(Ye,Mo,Da)+t];
%%
DateNumber=DateNumber+1;
for i=2:10 % this indicates to use the first 10 of the available 187 data files.
    c=datevec(DateNumber);Ye=c(1);Mo=c(2);Da=c(3);
    f2=[num2str(Ye,FORMAT) '_' num2str(Mo,FORMAT) '_' num2str(Da,FORMAT)]
    filename=[f2 '.dat']
    if exist(filename,'file')
        [x,y,t]=magload(filename,n);
    else
        display(['Download files from:' URL filename])
        urlwrite([URL filename],filename)    
        [x,y,t]=magload(filename,n);
    end
    X=[X,x];Y=[Y,y];T=[T,datenum(Ye,Mo,Da)+t];
    DateNumber=DateNumber+1;
end

save(['magsat_' f1  '_to_' f2 '.mat'], 'X' ,'Y','T')
