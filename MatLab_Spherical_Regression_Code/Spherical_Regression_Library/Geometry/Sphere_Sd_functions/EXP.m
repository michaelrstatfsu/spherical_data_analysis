%% Exponential Mapping from $T_p(S^(d-1))$ to $S^(d-1)\in R^d$
% The exponential
% map of $v \in T_p(S^(d-1))$ at the point $p \in S^(d-1)$ is expressed as
%
% $$EXP(v)= cos(\theta)*p +sin(\theta) $$
% 
% $$\theta=\|v\|$$
%
function y=EXP(v,p)
[Mv,N]=size(v);
[M,Np]=size(p);
if Np==1
    p=p*ones(1,N);
end
theta=sqrt(sum(v.^2));
y=(ones(Mv,1)*cos(theta)).*p+(ones(Mv,1)*sin(theta)).*v./(ones(Mv,1)*theta);
y(:,(theta<10^(-20)))=p(:,(theta<10^(-20)));

end
