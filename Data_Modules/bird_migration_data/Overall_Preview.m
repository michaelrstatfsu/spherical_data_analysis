function Z=Overall_Preview(ID,date,location,ind,ti)
% ID is the bird identification number for each observation
% date is the date for each observation
% location in geographical coordinates for each observation
%% Convert Geographical coordinates into unit vectors
[Z(1,:),Z(2,:),Z(3,:)]=sph2cart(pi*location(1,:)/180,pi*location(2,:)/180,1);
%% Sort the data
%[date,I]=sort(date);Z=Z(:,I); %sort everything by date
%THE DATA IS ALREADY SORTED
%% Report information about the dataset
% This will tell you how many birds are in the dataset and between what
% dates
startdate=min(date);enddate=max(date);
display('..................................................')
display(['There are ' num2str(length(unique(ID))) ' Birds in this data ranging from dates:'])
display([datestr(startdate) ' to ' datestr(enddate)])
end