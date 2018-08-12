function [pav ] = getResponsibility(x,g)

pav=[];
M=g.mu;
[r c]=size(M);
for i=1:r
    mu=g.mu(i,:);
    sig=g.Sigma(i,:);
    y = mvnpdf(x,mu,sig)*g.PComponents(i); 
    pav=[pav y];
end

% ind=find(pav==inf);
% pav=normalize(pav,0,1);
% pav(ind)=1;

%pav(~isfinite(pav))=1;
end

