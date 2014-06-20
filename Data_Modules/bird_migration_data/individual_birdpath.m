function [z,bird_dates]=individual_birdpath(ID,date,location,ind,ti)
% ID is the bird identification number for each observation
% date is the date for each observation
% location in geographical coordinates for each observation
% ind specify which bird you wish to look at
% ti (optional) specify which time interval dates as MatLab date numbers
%% Convert Geographical coordinates into unit vectors
[Z(1,:),Z(2,:),Z(3,:)]=sph2cart(pi*location(1,:)/180,pi*location(2,:)/180,1);
%% Sort the data
%[date,I]=sort(date);Z=Z(:,I); %sort everything by date
%THE DATA IS ALREADY SORTED
%% Report information about the dataset
% This will tell you how many birds are in the dataset and between what
% dates
startdate=min(date);enddate=max(date);
% display('..................................................')
% display(['There are ' num2str(length(unique(ID))) ' Birds in this data ranging from dates:'])
% display([datestr(startdate) ' to ' datestr(enddate)])
%% Report information about the selected bird
birds=unique(ID);   % bird identification number
id=birds(ind)==ID;  % id indexes the specified bird
bird_dates=[min(date(id)),max(date(id))]; % which dates are  observations available for this bird?
N=sum(id);
display(['Bird ' num2str(ind) ' has ' num2str(N) ' observations. The dates range from:'])
display([datestr(bird_dates(1)) ' to ' datestr(bird_dates(2))])
%%
%% Specify index of date and bird
if exist('ti','var')
    N=sum((date>=ti(1))&(date<=ti(2))&(birds(ind)==ID));
end
if N==0
    clear ti
    error('WARNING! NO OBSERVATIONS FOR DATE SPECIFIED')
end
if ~exist('ti','var')
    ti=[bird_dates(1),bird_dates(2)];
    % default setting is to use all available dates is user does not
    % specify a time interval.
end
    I=(date>=ti(1))&(date<=ti(2))&(birds(ind)==ID);
    N=sum(I);%How many observations are there?
%keyboard
%% Store Desired Observations with it's own observation
z=Z(:,I);
bird_dates=date(I);
%% Report what is being outputted
display(['There are '  num2str(N) ' observations outputted for bird '  num2str(ind)  ' with the specified dates:'])
display([datestr(ti(1)) ' to ' datestr(ti(2))])
end

