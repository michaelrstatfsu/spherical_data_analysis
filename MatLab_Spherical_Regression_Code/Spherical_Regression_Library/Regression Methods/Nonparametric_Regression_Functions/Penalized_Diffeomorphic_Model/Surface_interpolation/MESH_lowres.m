function [Grid2_lowres,Grid_lowres] = MESH_lowres(grid,grid2,N2)
if ~exist('N2','var')
    N2=50;
end
[Grid2_lowres,Grid_lowres] = lower_res( grid,grid2,N2);
MESH(Grid2_lowres);


end

