function V = UNIFORMdirections(m,n)
% generate n uniformly distributed m dim'l random directions
% Using the logic: "directions of Normal distribution are uniform on sphere"

V = zeros(m,n);
nr = randn(m,n); %Normal random 
for i=1:n
    while 1
        ni=nr(:,i)'*nr(:,i); % length of ith vector
        % exclude too small values to avoid numerical discretization
        if ni<1e-10 
            % so repeat random generation
             nr(:,i)=randn(m,1);
        else
             V(:,i)=nr(:,i)/sqrt(ni);
            break;
        end
    end
end

end