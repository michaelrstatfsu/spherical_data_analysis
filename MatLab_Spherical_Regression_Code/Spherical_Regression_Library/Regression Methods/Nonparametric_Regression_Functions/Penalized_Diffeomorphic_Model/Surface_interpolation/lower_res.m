function [ Grid2_lowres,Grid_lowres ] = lower_res( grid,grid2,N2 )
if ~exist('N2','var')
    N2=50;
end
Theta_lowres = repmat(linspace(10^(-4),pi-10^(-4),N2),N2,1);
Phi_lowres = repmat(linspace(0,2*pi,N2)',1,N2);
[Grid_lowres(:,:,1),Grid_lowres(:,:,2),Grid_lowres(:,:,3)]=s2c(Theta_lowres,Phi_lowres);
grid_lowres=reshape(Grid_lowres,N2*N2,3)';
[grid2_lowres]=interpsurf(grid,grid2,grid_lowres);
Grid2_lowres=reshape(grid2_lowres',N2,N2,3);

end

