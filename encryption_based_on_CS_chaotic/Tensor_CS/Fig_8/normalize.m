% Normalize Dictionary
function [D] = normalize(D)
M = size(D,2);
for m = 1:M
    D(:,m) = D(:,m)./norm(D(:,m),'fro');
end

end