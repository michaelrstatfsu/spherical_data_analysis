This data module is for analyzing hurricane track data from
http://www.ncdc.noaa.gov/ibtracs/index.php?name=wmo-data

The data can be previewed online at
http://csc.noaa.gov/hurricanes/#app=6078&3e3d-selectedIndex=1

The main function Hurricane.m is made to run after downloading and unzipping the 'Allstorms.ibtracs_wmo.v03r05.csv.gz' file found at
ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r05/wmo/csv/

One can do this manually. For those running debian linux who have the wget and gzip programs installed 
sudo apt-get install wget gzip # To install from terminal
One can automatically download and unzip the file by uncommenting the following code in the creat_hurricane_Tracks.m script.
% system(['wget ' url]);
% system(['gunzip ' filename '.gz'])

The main function Hurricane.m will automatically import and save the csv file as a mat file for future use and then plot select hurricanes which meet the selected criteria. This script requires the globe function defined in the Spherical_Regression_Library directory, so make sure to add those subdirectory to the Matlab search path.
