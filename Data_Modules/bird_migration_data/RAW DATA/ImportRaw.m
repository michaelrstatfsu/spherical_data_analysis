% Import the Data from Raw text imput
%%
clear
fid=fopen('clean_pintail_data');
for i=1:8813
str=fgetl(fid);
I=findstr(str,',');
location(1:2,i)=[str2num(str(1:(I(1)-1))),str2num(str((I(1)+1):(I(2)-1)))];
date(i)=datenum(str((I(3)+1):(I(4)-1)));
ID(i)=str2num(str((I(4)+1):end));
end
save pintail_data.mat
%%
clear
fid=fopen('Turkey_Vulture_clean.csv');
for i=1:213757
str=fgetl(fid);
I=findstr(str,',');
date(i)=datenum(str(1:(I(1)-1)));
location(1:2,i)=[str2num(str((I(1)+1):(I(2)-1))),str2num(str((I(2)+1):(I(3)-1)))];
ID(i)=str2num(str((I(3)+1):end));
end
save Turkey_Volture_data.mat
%%
clear
fid=fopen('Swainson_Hawks_clean.csv');
for i=1:4514
str=fgetl(fid);
I=findstr(str,',');
date(i)=datenum(str(1:(I(1)-1)));
location(1:2,i)=[str2num(str((I(1)+1):(I(2)-1))),str2num(str((I(2)+1):(I(3)-1)))];
ID(i)=str2num(str((I(3)+1):end));
end
save Swainson_Hawks_data.mat
%%
clear
fid=fopen('Brant_Geese_Sean_Boyd_2005_CLEANED.csv');
for i=1:17652
str=fgetl(fid);
I=findstr(str,',');
date(i)=datenum(str(1:(I(1)-1)));
location(1:2,i)=[str2num(str((I(1)+1):(I(2)-1))),str2num(str((I(2)+1):(I(3)-1)))];
ID(i)=str2num(str((I(3)+1):end));
end
save Brant_Geese_data.mat