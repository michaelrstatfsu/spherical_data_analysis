function [h]=SURF(Grid,diam)
if ~exist('diam','var')
    diam=1;
end
h=surf(Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)); colormap(.7*gray)
set(gca,'linewidth',2,'fontsize',20);
set(h,'LineWidth',diam);
axis equal
end
