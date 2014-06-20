%%
close all;
if ~exist('figtype','var')
    clear all
    % argV=' 0,''color'',[0.9 0 0],''linewidth'',1 ';
    % argVhat=' 0,''y'',''linewidth'',1 ';
    figtype='-depsc';figext='.eps';
end
filename='Mapping_Example';
linethick=1.2
ZOOM=1.9;
%% Contruct Grid
load GRID_3_30.mat;
%% Diffeo Example
epsilon=.4;
[grid2]=EXP(epsilon*btan(:,:,30),grid);
[ Grid2,Grid ]=lower_res( grid,grid2,30 );
% Grid2=reshape(grid2',NN,NN,3);
close all
MESH(Grid2)
surf(Grid2(:,:,1),Grid2(:,:,2),Grid2(:,:,3),'linewidth',linethick);colormap(gray);axis equal
zoom(ZOOM)
print(figtype,[  filename '_diffeo' figext]);
%% Non-Bijective Example
load  'weatherballoon.mat'
close all
kappa=18;
[ grid2] = taylor(X,Y,grid,kappa);
%  [ Grid2,Grid ]=lower_res( grid2,grid,60 );
Grid2=reshape(grid2',NN,NN,3);
close all
surf(Grid2(:,:,1),Grid2(:,:,2),Grid2(:,:,3),'edgecolor','none');colormap(gray);axis equal
hold on
surf(1.02*Grid2(:,:,1),Grid2(:,:,2),1.0*Grid2(:,:,3),'FaceColor','none','linewidth',linethick);colormap(gray);axis equal
zoom(ZOOM)
view([-1,-1,0])
print(figtype,[  filename '_non_bijective' figext]);
%% Discontinuos Example
[x,y,z] = sphere(30);
domeRadius =  1;
xEast  = x;xEast(xEast < 0) = 0;
yNorth = y;
zUp    = z;

close all;
surf(xEast, yNorth, zUp,'linewidth',linethick);colormap(gray)
hold on
xEast  = -x;xEast(xEast > 0) = 0;
yNorth = z;
zUp    = y;
surf(xEast, yNorth, zUp,'linewidth',linethick);colormap(gray)
axis equal
zoom(ZOOM)

print(figtype,[  filename '_discontinuous' figext]);