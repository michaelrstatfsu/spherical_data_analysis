function [ Z] = center(X,Y)
        [d,N]=size(X);
        M=mean(X,2);
        M=M./sqrt(sum(M.^2));
        arbitrary_direction= zeros(d,1);
        arbitrary_direction(d)= 1;
        %keyboard
        for i=1:N
            Z(:,i)=rotMat(X(:,i),arbitrary_direction )*Y(:,i);
        end

end

