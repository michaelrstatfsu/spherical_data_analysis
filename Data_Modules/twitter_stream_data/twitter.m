%%
clear
c=clock()
%% today's data
date=[num2str(c(1)) '_' num2str(c(2)) '_' num2str(c(3))]
%% specify your own date
% date='2014_1_10';
%% Specify File Directories
tweet_data=[' Data/tweet_' date '.txt ']
sentiment_lib=[' Data/AFINN-111.txt ']
% sentiment_lib=[' Data/term_lib.txt ']
sentiment_data=[' Data/sentiment_data ']
image_type='-dpng';image_ext='.png';
%%
addpath(genpath('Plotting_Functions'))
%% Get 1000 tweets from stream
cmd=['python twitterstream.py >> ' tweet_data]
system(cmd)
%% extract coordinates of data
cmd=['python coordinate.py ' sentiment_lib tweet_data]
system(cmd)
%% Import Data Into Matlab
filename = 'Data/coordinate_data.txt';
delimiter = '\t';
formatSpec = '%f%f%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
lat = dataArray{:, 1};
lon = dataArray{:, 2};
tweet = dataArray{:, 3};
sentiment = dataArray{:, 4};
clearvars filename delimiter formatSpec fileID dataArray ans;
%% Convert into Cartesian Coodinates
clear X
[X(:,1),X(:,2),X(:,3)]=sph2cart(pi*lat/180,pi*lon/180,1);X=X';
[M,N]=size(X);
%% Plot Data
cdata = imread('earth_1600.jpg');
[a, b, c] = ellipsoid(0, 0, 0, 1, 1,1, 32);
    
for n=randsample(1:N,1);
    x=X(:,n);
    l=x+ones(3,1); 
    
    % plot globe
    close all
    figure('units','normalized','outerposition',[0 0 1 1])
    g=mesh(a, b, -c,'FaceColor', 'texturemap',...
        'CData', cdata, 'EdgeColor','none'); axis equal    
    
    % plot geographical locations of tweets
    hold on
    scatter3(X(1,:),X(2,:),X(3,:),50,'red','fill'); colormap(jet)

    % plot a tweet
    quiver3(x(1),x(2),x(3),l(1),l(2),l(3),0,'yellow','linewidth',2)
    h=text(l(1),l(2),l(3),tweet{n})
    set(h,'BackgroundColor','yellow')
    scatter3(x(1),x(2),x(3),200,'yellow')
    view(x)
    zoom(-1)
    % print image    
    image_name=['PLOTS/tweet_'  date '_'  num2str(lat(n)) '_' num2str(lon(n))]
    print(image_type,[image_name image_ext])
end
