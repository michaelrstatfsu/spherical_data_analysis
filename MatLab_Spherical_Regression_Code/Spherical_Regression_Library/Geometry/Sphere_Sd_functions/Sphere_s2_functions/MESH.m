function [h]=MESH(Grid,image_file,diam)
if ~exist('diam','var')
    diam=1;
end
if ~exist('image_file','var')
        args='''FaceColor'', ''w'',''facealpha'',.95,''EdgeColor'',''black''';
        eval([ 'h=mesh(Grid(:,:,1),Grid(:,:,2),Grid(:,:,3),' args ');']);
else
    if isempty(image_file)
        args='''FaceColor'', ''w'',''facealpha'',.95,''EdgeColor'',''black''';
        eval([ 'h=mesh(Grid(:,:,1),Grid(:,:,2),Grid(:,:,3),' args ');']);
    else
    cdata = imread(image_file);
    [r,c,m]=size(cdata);
    cdata=[cdata(:,(c/2+1):end,:),cdata(:,1:(c/2),:)];
    h=mesh(Grid(:,:,1)',Grid(:,:,2)',Grid(:,:,3)','FaceColor', 'texturemap',...
        'CData', cdata, 'EdgeColor','none');
    end
end
set(gca,'linewidth',2,'fontsize',20);
set(h,'LineWidth',diam);
axis equal
end
