%% Advanced Example Using Landmarks from two images
clear;close all
%%  In This example we will construct data from two images
name1='clouds_9_04_12.jpg';
name2='clouds_9_05_12.jpg';
[cloudx]=imread([name1]);
[cloudy]=imread([name2]);
%% Crop windows to Desired size
minx=600;
maxx=950;
miny=200;
maxy=900;
figure(1)
imshow(cloudx(minx:maxx,miny:maxy))
figure(2)
imshow(cloudy(minx:maxx,miny:maxy))
%% select data points from croped window
[lands,cmap2]=imread('earth_1600.jpg');
x=[250 236
    361 216
    141 184
    196 212
    170 199
    223 225
    46 51
    93 118
    73 84
    111 149
    159 264
    184 260
    220 248
    237 243
    203 255
    254 289
    314 265
    290 277
    343 247
    355 233
    82 56
    198 134
    275 165
    137 95
    324 202
    220 148
    304 180
    113 70
    167 114
    ]';

y=[ 473 239
    521 224
    238 201
    353 231
    296 221
    414 236
    51 44
    138 125
    92 80
    184 162
    126 291
    176 289
    298 282
    365 264
    230 289
    361 322
    435 288
    404 301
    484 269
    511 250
    102 44
    247 150
    368 168
    172 100
    482 202
    292 165
    433 179
    138 66
    208 126
    ]';
close all
figure(1)
imshow(cloudx(minx:maxx,miny:maxy))
figure(1);hold on;scatter(x(1,:),x(2,:),50,'fill',...
    'black','MarkerEdgeColor','white')
figure(2)
imshow(cloudy(minx:maxx,miny:maxy))
hold on;scatter(y(1,:),y(2,:),50,'fill',...
    'black','MarkerEdgeColor','white')

%% Convert to cartesian coordinates
X=pix2geo(cloudx,x(1,:)+miny,x(2,:)+minx);
Y=pix2geo(cloudx,y(1,:)+miny,y(2,:)+minx);
size(X)
%%
figure(3);close;figure(3);
globe(X,'earth_1600.jpg');hold on; 
globe_layer([name1],.99);
center=mean(X,2); center= center/norm(center);
view(center);zoom(3);
grid off
%
figure(4);close;figure(4);
globe(Y,'earth_1600.jpg');hold on; 
globe_layer([name2],.99);hold on;
center=mean(Y,2); center= center/norm(center);
view(center);zoom(3);
grid off