function globe_layer(image_file,radius)
colormap('gray')
if ~exist('radius','var')
    radius=1;
end
if exist('image_file','var')
    if ~isempty(image_file)
        cdata = imread(image_file);
        %keyboard
        alpha_data=sqrt(sum(double(cdata).^2,3));
        [x, y, z] = ellipsoid(0, 0, 0, radius, radius,radius, 72);
        g= mesh(x, y, -z,'FaceColor', 'texturemap',...
            'CData', cdata, 'FaceAlpha','texture', 'EdgeColor',...
            'none','AlphaDataMapping','scaled','alphadata',alpha_data);
    end
end
axis equal
set(gca,'fontsize',20,'linewidth',2)
end