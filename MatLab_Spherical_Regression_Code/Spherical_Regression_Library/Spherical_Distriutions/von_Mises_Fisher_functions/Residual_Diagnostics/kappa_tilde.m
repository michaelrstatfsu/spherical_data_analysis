function [ kappatilde] = kappa_tilde(Z,Y)
if exist('Y','var')
    Z=center(Z,Y);
    clear Y
end

%KAPPA_TILDE Newton method
maxitr=1;
kappatilde=zeros(maxitr,1);
i=1; go=1;
[M,N]=size(Z);
Rbar=resultant_length(Z);
kappatilde(1)=(Rbar*(M-Rbar^2))/(1- Rbar^2);
while (i<maxitr)&(go==1)
    i=i+1;
    A_p_kappa=resultant_length(M,kappatilde(i-1));
    kappa=kappatilde(i-1);
    kappatilde(i)=kappa-( (A_p_kappa-Rbar)/(1-A_p_kappa^2- ((M-1)/kappa)*...
        A_p_kappa));
    %go=abs(kappatilde(i-1)-kappatilde(i))>.001;
end
kappatilde=kappatilde(i);
end

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
