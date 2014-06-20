Integrated Global Radiosonde Archive (IGRA) v1.20 Readme File (July 2007)



I. General Information

This file lists the contents of the IGRA ftp directory and describes the
format of the various sounding, monthly-mean, and station inventory 
files available.

Imke Durre (imke.durre@noaa.gov) - (last updated January 2011)



II. Contents of ftp://ftp.ncdc.noaa.gov/pub/data/igra

---------------------------------
Directories:
---------------------------------

data-por     Period of record data files (base version through 2008 + daily
             updates; one file per station)
data-y2d     Daily updates since January 1, 2009 (replaced daily; 
             one file per station)
derived      Version 1 of IGRA-derived parameters (includes period-of-record 
             station files and documentation).
derived-v2   Version 2 of IGRA-derived parameters (includes period-of-record 
             station files and documentation).
monthly-por  Period of record monthly-mean files (updated monthly)
monthly-upd  Files of monthly means for the last month only (replaced monthly)

---------------------------------
Files:
---------------------------------

igra-composites.txt            IGRA stations with composited records
igra-countries.txt             List of country codes used in the station list
igra-metadata20090527.txt      IGRA station history and metadata inventory
igra-metadata-description.txt  Description and format of igra-metadata.txt
igra-qc.pdf                    Paper describing IGRA quality-control 
                               for temperature (J. Climate, in press)
igra-overview.pdf              Paper describing IGRA (J. Climate, 2006)
igra-stations.txt              List of stations in IGRA
readme.txt                     This file 
status.txt                     Notes on the current status of IGRA's 
                               online files


III. Format Description of IGRA Data Files

---------------------
Notes:
---------------------

1. There is one file per station, named #####.dat, where ##### is the 
station number. 

2. Each sounding consists of one header record and n data 
records, where n (given in the header record) is the number of levels
in the sounding.

3. For all variables in the data record except the level type indicators,
-8888 indicates that the original value has been removed by one of the IGRA
quality assurance procedures, while -9999 means that the data value was
never present.

4. For each pressure, geoppotential height, and temperature value, a
one-character quality assurance flag indicates whether the corresponding
value was checked by procedures based on climatological means and standard
deviations. Possible flag values are: blank = no climatological check
applied due to an insufficient number of data values for computing the
relevant statistics, A = value falls within "tier-1" climatological limits
based on all days of the year and all times of day at the station, and
B = value passes checks based on both the tier-1 climatology and a
"tier-2" climatology specific to the time of year and time of day of the data 
value.



---------------------
Header Record Format:
---------------------


  Variable Name            Columns  Description
  -----------------------  -------  -----------

  Header Record Indicator    1-  1  # character 

  Station Number             2-  6  WMO station number

  Year                       7- 10   

  Month                     11- 12

  Day                       13- 14

  Observation Hour          15- 16  00-23 UTC

  Release Time              17- 20  0000-2359 UTC, 9999 = missing

  Number of levels          21- 24  number of subsequent data records



---------------------
Data Record Format:
---------------------


  Variable Name            Columns  Description
  -----------------------  -------  -----------

  Major Level Type           1-  1  1 = standard pressure level
                                    2 = significant thermodynamic level
                                    3 = additional wind level

  Minor Level Type           2-  2  1 = surface, 2 = tropopause, 0 = other 


  Pressure                   3-  8  units of Pa (mb * 100)

  Pressure Flag              9-  9  A, B, or blank (see note 4 above)

  Geopotential Height       10- 14  units of meters

  Geopotential Height Flag  15- 15  A, B, or blank (see note 4 above)

  Temperature               16- 20  units of degrees C * 10

  Temperature Flag          21- 21  A, B, or blank (see note 4 above)

  Dewpoint Depression       22- 26  units of degrees C * 10

  Wind Direction            27- 31  units of degrees (0-360, inclusive)

  Wind Speed                32- 36  units of (m/s)*10



IV. Format of IGRA Monthly-Mean Files

---------------------------------
Notes:
---------------------------------

1. File names are of the form VVVV_HHz.mly, where VVVV = variable and HH = 
   nominal hour.
   Possible values for VVVV: ghgt = geopotential height, temp = temperature,
     uwnd = zonal wind component, vwnd = meridional wind component.

   Possible values for   HH: 00, 12.

2. Monthly means are computed for the surface and mandatory levels at the 
   nominal times of 00 and 12 UTC, considering data within two hours of each 
   nominal time.

3. A mean is provided only if there are at least 10 values for a particular 
   station, month, nominal time, and level. 

4. Means are given in units of meters for geopotential height, degrees C * 10
   for temperature, and (m/s) * 10 for zonal and meridional wind.


---------------------------
File Format (VVVV_HHz.mly):
---------------------------

  Variable Name             Columns  Description
  ------------------------  -------  -----------

  Station Number              1-  5  WMO station number

  Year                        7- 10

  Month                      12- 13

  Pressure Level             15- 18  units of HPa (mb), 9999 = Surface level

  Mean Value                 20- 24  see Note 4 above for units

  Number of Values in Mean   26- 27

V. Format Description of IGRA Station Inventory Files

---------------------------------
Station List (igra-stations.txt):
---------------------------------

  Notes:
  ------

  In the station list, stations are identified as GUAN, former GUAN,
  Lanzante-Klein-Seidel, or composite stations if applicable. The following
  notes apply to these identifications:
  1. GUAN stands for Global Climate Observing System Upper Air Network,
     see http://www.wmo.ch/web/gcos/gcoshome.html

  2. The Lanzante-Klein-Seidel network is described in the following paper: 
     Lanzante, J.R., S.A. Klein, D.J. Seidel, 2003:
     Temporal homogenization of monthly radiosonde temperature data. Part I:
     Methodology. Journal of Climate, 16, 224-240.
     See http://ams.allenpress.com/
              amsonline/?request=get-toc&issn=1520-0442&volume=016&issue=02

  3. Composite means that the data from two or more source stations have been
     combined into one IGRA station. See igra.composite.stations for a list of
     these stations.



  Variable Name            Columns  Description
  -----------------------  -------  -----------

  Country Code (FIPS)        1-  2  see igra-countries.txt

  Station Number             5-  9  WMO station number

  Station Name              12- 46   

  Latitude                  48- 53  units of decimal degrees

  Longitude                 55- 61  units of decimal degrees

  Elevation                 63- 66  units of meters above sea level 

  GUAN Code                 68- 68  G = current GUAN station
                                    F = former GUAN station
                                    blank = other (see Note 1)

  LKS Network Code          69- 69  L = Lanzante-Klein-Seidel station 
                                    blank = other (see Note 2)

  Composite Station Code    70- 70  C = Composite station
                                    blank = other (see Note 3)

  First Year of Record      73- 76

  Last Year of Record       78- 81



---------------------------------------
Country Code List (igra-countries.txt):
---------------------------------------

  Note: 
  ------
  Country codes are taken from Federal Information Processing Standard
  (FIPS) Publication 10-4 
  (http://www.cia.gov/cia/publications/factbook/appendix/appendix-d.html).

  Variable Name            Columns  Description
  -----------------------  -------  -----------

  Country Code               1-  2  2-character FIPS code used in 
                                    igra-stations.txt

  Country Name               5- 44  



-----------------------------------------------------
List of Composite Stations (igra-composites.txt):
-----------------------------------------------------

  Note:
  ------
  The compositing was performed using data through the end of 2006. 
  Consequently, the dates provided in the composite station list do not 
  extend beyond 2006. Nevertheless, like all other stations, composite 
  stations are continuously updated with data received under the 
  corresponding current station number.  
  Variable Name            Columns  Description
  -----------------------  -------  -----------
  
  Composite Station Info:
     Station Number          1-  5  WMO number of composite station
     Date of First Record:
        Year                 7- 10
        Month               11- 12
        Day                 13- 14
        Hour                15- 16
     Date of Last Record:
        Year                18- 21
        Month               22- 23
        Day                 24- 25
        Hour                26- 27
  
  Source Station 1:
     Station Number         30- 34  WMO number of source station 1
     Date of First Record:
        Year                36- 39
        Month               40- 41
        Day                 42- 43
        Hour                44- 45
     Date of Last Record:
        Year                47- 50
        Month               51- 52
        Day                 53- 54
        Hour                55- 56
  
  Source Station 2:
     Station Number         59- 63  WMO number of source station 2
     Date of First Record:
        Year                65- 68
        Month               69- 70
        Day                 71- 72
        Hour                73- 74
     Date of Last Record:
        Year                76- 79
        Month               80- 81
        Day                 82- 83
        Hour                84- 85

