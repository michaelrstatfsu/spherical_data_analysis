%% Inverse Molleweide Mapping
% This function takes pixles from a Molleweide map image and converts them
% to cartesian coordinates on $S^2$. The image should be
% representated as a $h\times w \times m$ array which has been propery
% centered and croped so that there are no margins. The variables $px$
% denotes the pixel column and $py$ denotes the selected pixel rows. $px$
% and $py$ must must be vectors of equal length. 
%
% Note that if a pixel point is select that is not on the map, then that
% gets mapped to the origin [0 0 0]'.

%% Example
% load raw image

% URL='http://www.ssec.wisc.edu/data/comp/latest_moll.jpg';
% image_raw=imread(URL);
% imshow(image_raw)

%% preprocess raw image to remove margins
% Trime the margins so that the ellipse matches the image.

% [h0,w0,~]=size(image_raw);
% lm=8;  % left Margin
% rm=8;  % right Margin
% tm=21; % top Margin
% bm=21; % bottom Margin
% image=image_raw(tm:(h0-bm),lm:(w0-rm),:);

%% select pixels

% pixels=[179 92
%     253 168
%     293 92
% ]';
% [ p ] = inverse_mollweide(pixels(1,:),pixels(2,:),image)

%% The function
function [ p ] = inverse_mollweide(px,py,image)
[h,w,~]=size(image);
p=zeros(3,length(px));
% find the points which are on the map
Ind=(2*(px-w/2)/w).^2+(2*(py-h/2)/h).^2 < 1; 
if sum(Ind)>0
    x=2*sqrt(2)*(px(Ind)-w/2)/w;
    y=2*sqrt(2)*(h/2-py(Ind))/h;
    theta=asin(y/sqrt(2));
    phi= asin((2*theta+sin(2*theta))/pi);
%     lambda=pi*x./(2*sqrt(2)*cos(theta));
    lambda=pi*x./(2*sqrt(2)*cos(theta));
    [px,py,pz] = sph2cart(2*lambda,phi,1);
    p(:,Ind)=[px;py;pz];
end
end

