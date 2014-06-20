%% Spherical Harmic Basis Vector Feild
%% spherharmbasis object class
% Describe Spherical Harmonics, and the Tangent Vectors here
classdef spherharmbasis
    properties
        %%
        l
        n
        L
        %% Spherical Coordinates
        % These
        Theta;
        theta;
        Phi;
        phi;
        %% Cartesian Coordinates
        X;
        Y;
        Z;
        p;
        GRID;
        grid;
        %% Spherical Harmonics
        Psi;
        %% Tangent Vectors
        b;
        btan;
    end
    methods
        function S=spherharmbasis(l,n)
            if ~exist('n')
                l=2
                n=20
            end
            %%
            S.n=n;S.l=l;
            S.L=2*(l+1)^2-2;
            display('Obtaining Harmonic Basis')
            [Theta,Phi,Psi,b] = spherharmbasis1(l,n);[~,~,~,L]=size(b);
            %% Initialize Spherical and Cartesian Coordinates
            Theta(:,:,2:L)=zeros(n,n,L-1);Phi(:,:,2:L)=zeros(n,n,L-1);
            X=zeros(n,n,L);Y=zeros(n,n,L);Z=zeros(n,n,L);
            [X(:,:,1),Y(:,:,1),Z(:,:,1)]=s2c(Theta(:,:,1),Phi(:,:,1));
            %% Compute Adjusted Coordinates For each Basis Vector Field
            display('Compute Adjusted Coordinates for each Basis Vector Field')
            ten=round(S.L/10);
            for j=2:L
                Theta(:,:,j)=Theta(:,:,1)+b(:,:,1,j);
                Phi(:,:,j)=Phi(:,:,1)+b(:,:,2,j);
                X(:,:,j)=sin(Theta(:,:,j)).*cos(Phi(:,:,j));
                Y(:,:,j)=sin(Theta(:,:,j)).*sin(Phi(:,:,j));
                Z(:,:,j)=cos(Theta(:,:,j));
                if mod(j,ten)==1
                    fprintf([ num2str(100*j/S.L) '%% \n'])
                end
            end
            fprintf('\n')
            % Set the properties of spherharmbasis object.
            S.Theta=Theta;S.Phi=Phi;S.theta=Theta(1:end);S.phi=Phi(1:end);
            S.X=X;S.Y=Y;S.Z=Z;
            S.Psi=Psi;
            S.b=b;
            x1=X(:,:,1);y1=Y(:,:,1);z1=Z(:,:,1);
            S.p=[x1(1:end);y1(1:end);z1(1:end)];% Registered point
            S.btan=zeros(3,S.n,S.n,S.L);
            display(['Constructing Tangent Vectors'])
            for j=2:L
                display([num2str((j/L)*100) '%'])
                xj=S.X(:,:,j);yj=S.Y(:,:,j);zj=S.Z(:,:,j);
                W=[xj(1:end);yj(1:end);zj(1:end)]; % Warped point
                for n=1:size(W')
                    if sum((W(:,n)-S.p(:,n)).^2)>10^-10
                        u(:,n)=INVEXP(W(:,n),S.p(:,n)); % tangent vector in R3
                    else
                        u(:,n)=S.p(:,n);
                    end
                end
                if isnan( u(:,n))
                    keyboard
                end
                %                 keyboard
                S.btan(:,:,:,j)=reshape(u,3,S.n,S.n);
            end
            display([ num2str(S.L) 'Basis elements parametrized with ' num2str(n)  'X' num2str(n) 'grid.'])
        end
        function S=Btan(S,j)
            %% Compute Tangent Vectors in $R^3$
            if j==1
                S.btan(:,:,:,1)=zeros(3,S.n,S.n,1);
            end
            if isequal(S.btan(:,:,:,j),zeros(3,S.n,S.n,length(j)))*(j>1)             
                xj=S.X(:,:,j);yj=S.Y(:,:,j);zj=S.Z(:,:,j);
                W=[xj(1:end);yj(1:end);zj(1:end)]; % Warped point
                for n=1:size(W')
                    u(:,n)=INVEXP(W(:,n),S.p(:,n)); % tangent vector in R3
                end
                %                 keyboard
                S.btan(:,:,:,j)=reshape(u,3,S.n,S.n);
                display(['Computed Tangent Vectors for Basis ' num2str(j)])
            end
        end
        
        %% Plot a Tangent Vector Field
        % The following function plots a given tangent vector feild
        function S=plottan(S,btan,p);
            %% Specify the vector feild
            % the arguement btan can either be a integer from 1,\ldots, L,
            % or it can be a $3\times N$ matrix. Note that btan cannot be
            % an arbitrary matrix, and if it is a matrix you must include p
            % as well.
            % If you would like to plot tangent vectors at arbitrary
            % locations on the sphere, you need to specify the tangent
            % vectors btan ($3\times N$) which are points in $R^3$ and
            % the corresponding locations on the sphere of
            % the tangent spaces p ($3\times N$) which are points in $S^2$
            % If btan is
            % an integer, the $j^{th}$ tangent vector field will be plotted
            % at gridpoints used to parametrize the vector feild.
            %% Optional Arguement p
            if isequaln(size(btan),[1,1])
                S=S.Btan(btan);
                btan=S.btan(:,:,:,btan);
                btan=reshape(btan,3,S.n*S.n);
                p=S.p;
            end
            mesh(S.X(:,:,1),S.Y(:,:,1),S.Z(:,:,1)); hold on; axis equal
%             keyboard
            quiver3(p(1,:),p(2,:),p(3,:),...
                btan(1,:),btan(2,:),btan(3,:),...
                'AutoScale','off')
            set(gca,'linewidth',2,'fontsize',18)
        end
        function P=plotgrid(S,btan,p)
            if isequaln(size(btan),[1,1])
                btan=S.btan(:,:,btan);
                p=S.p;
            end
            %%
            [M,N]=size(btan)
            for n=1:N
                pnew(:,n)=EXP(btan(:,n),p(:,n));
            end
            %%%
            P=reshape(pnew,3,S.n,S.n);
            mesh(squeeze(P(1,:,:)),squeeze(P(2,:,:)),squeeze(P(3,:,:)))
            axis equal;
            set(gca,'linewidth',2,'fontsize',18)
        end
        %% Compute $b_j(x)$
        % The following function computes $b_j(x)$. This is accomplished by
        % resampling a particular basis tangent vector field j
        % at arbitrary points on the sphere $X$ $(3\times N)$.
        function [bnewtan,bnew]=B(S,j,X)
            % Convert cartesian coordinated into spherical coordinates.
            [theta,phi]=c2s(X(1,:),X(2,:),X(3,:));
            % Interpolate the spherical coordinates from the parametrized
            b=S.b(:,:,:,j);
            [W,bnewtan,bnew]=interptan(S.Theta(:,:,1),S.Phi(:,:,1),b,X);
        end
    end
    
    
end

