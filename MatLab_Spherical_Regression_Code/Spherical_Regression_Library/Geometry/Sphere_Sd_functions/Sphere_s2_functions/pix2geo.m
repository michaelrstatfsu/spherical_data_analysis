function [X]=pix2geo(clouds,i,j)
%%
[lonlength,latlength]=size(clouds);
lonmid=lonlength/2;
lon= pi*(lonmid-i)/lonlength;
latmid=latlength/2;
lat=-pi+ 2*pi*(j)/latlength;
[X(1,:),X(2,:),X(3,:)]=sph2cart(lat,lon,1);
[N]=size(i);
X=X./(ones(3,1)*sqrt(sum(X.^2)));


end