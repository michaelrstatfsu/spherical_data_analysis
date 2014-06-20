function h=QUIVER3(grid,v,arg)
[M,N1]=size(grid);
[M,N2]=size(v);
if ~exist('arg','var')
    arg=' 0,''blue'',''linewidth'',2 ';
end
if N1==N2;
    eval(['h=quiver3(grid(1,:),grid(2,:),grid(3,:),v(1,:),v(2,:),v(3,:),' arg ');']);
else
    for n1=1:N1
    for n2=1:N2
    eval(['h=quiver3(grid(1,n1),grid(2,n1),grid(3,n1),v(1,n2),v(2,n2),v(3,n2),' arg ');']);
    end
    end
end
end
