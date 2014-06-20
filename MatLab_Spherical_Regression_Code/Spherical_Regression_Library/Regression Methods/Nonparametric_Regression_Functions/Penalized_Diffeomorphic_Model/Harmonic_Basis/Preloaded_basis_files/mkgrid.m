function [ Grid ] = mkgrid(l,NN)
%     [~,whoami]=system('whoami');
if l==0
    n=NN-1;
    theta = pi*[.01:n+1-.01]/(n+.02);
    phi = 2*pi*[0:n]/n;
    Theta = repmat(theta,n+1,1);
    Phi = repmat(phi',1,n+1);
    [Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
else    
    filename=['GRID_' num2str(l) '_' num2str(NN) '.mat'];
    if exist(filename, 'file')
        display(['File Already Exists:'  filename])
    else
        display(['Creating Basis File: ' filename])
        % l=10;NN=60;
        
        L=2*(l+1)^2-2;
        NNNN=NN*NN;
        [Theta,Phi,~,B] = spherharmbasis1(l,NN);
        % construct Grid in Cartesian Coordinates
        [Grid(:,:,1),Grid(:,:,2),Grid(:,:,3)]=s2c(Theta,Phi);
        % vectorize grid inputs
        theta=reshape(Theta,NNNN,1);phi=reshape(Phi,NNNN,1);b=reshape(B,NNNN,2,L);
        grid=reshape(Grid,NNNN,3)';
        % Construct Basis of Tangenet Vectors
        v1=h1(theta,phi);
        v2=h2(theta,phi);
        btan=zeros(3,NNNN,L);
        %     keyboard
        for j=1:L
            btan(:,:,j)=v1.*(ones(3,1)*b(:,1,j)')+v2.*(ones(3,1)*b(:,2,j)');
            Btan(:,:,:,j)=reshape(btan(:,:,j)',NN,NN,3 );
        end
        %     keyboard
        save(filename,'btan', 'B', 'Btan', 'Grid', 'L', 'NN', 'NNNN',...
            'Phi', 'Theta', 'b','phi', 'grid', 'theta')
    end
end
end

