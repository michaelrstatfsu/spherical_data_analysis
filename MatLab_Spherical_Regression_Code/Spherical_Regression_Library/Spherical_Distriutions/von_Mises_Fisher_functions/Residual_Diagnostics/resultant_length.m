function [ Rbar] = resultant_length(X,Y)
if length(X)>1
    if ~exist('Y','var')
        % if only one input then calculate the resultant length of that one
        % input.
        Z= X;
    else
        %% Center the response datapoints
        Z=center(X,Y);
        %% calculate the estimate resultant length
    end    
    if length(Z)>1
        [d,N]=size(Z);
        Rbar=sqrt(sum((sum(Z,2)).^2))/N;
    end
else
    Rbar=True_Resultant(X,Y);
end
end

function A_p_kappa=True_Resultant(d,kappa)
%% calculate $A_p(\kappa)$
denom=besseli(d/2-1,kappa,1);
if denom ~= Inf
    A_p_kappa=besseli(d/2,kappa,1)/denom;
else
    A_p_kappa=1;
end

end

