function globe(Z,image_file,radius)
if ~exist('radius','var')
    radius=.97;
end
%[x, y, z] = ellipsoid(0, 0, 0, .97, .97,.97, 72);
if exist('image_file','var')
    if isempty(image_file)
        %%
	[x,y,z] =ellipsoid(0, 0, 0, radius, radius,radius, 20);
    	g=mesh(x,y,z,'edgecolor','black');
        colormap(gray)
        
    else
	cdata = imread(image_file);
        [x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 32);
        g=mesh(x, y, -z,'FaceColor', 'texturemap',...
            'CData', cdata, 'EdgeColor','none');
    end
end
axis equal;colormap(gray(100)*.8);
if exist('Z','var')
    if length(Z)>0;
        hold on;
        scatter3(Z(1,:),Z(2,:),Z(3,:),50,[.9,.9,.9],'fill','MarkerEdgeColor','black',...
            'LineWidth',2)
    end
end
axis equal
set(gca,'fontsize',20,'linewidth',2)
end
