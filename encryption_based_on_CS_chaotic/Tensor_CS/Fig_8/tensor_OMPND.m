%% Matlab Code for the N-Way OMP algorithm as described in the paper:
% "Computing Sparse Representations of Multidimensional Signals Using Kronecker Bases" by C. Caiafa & A. Cichocki,
% Neural Computation Journal, Vol. 25, No. 1 , pp. 186-220, 2013.
% Find a s-sparse representation of a tensor Y, i.e. 
% Y = X \times_1 D_1 \times_2 D_2...\times_N D_N
% where X(i_1,i_2,...,i_N)=0 for all i_n \notin I_n and |I_n|=s(n)


function [X,Ind] = tensor_OMPND(D,Y,s,epsilon)
[I] = size(Y);
N = size(I,2);

for n = 1:N
    M(n) = size(D{n},2);
end

norma = norm(reshape(Y,[I(1),prod(I)/I(1)]),'fro');

R = Y; % initial residual
Ind = cell(1,N); % set of indices to select for each mode
L = cell(1,N); % Triangular matrices used in Cholesky factorization of each mode
Dsub = cell(1,N); % subset of selected atoms per each mode

% auxiliar variables for searching the maximum of a tensor
v = cell(1,N); 
add = cell(1,N); 

ni = zeros(1,N); % number of selected indices in each mode

% Initialization
for n = 1:N
    Ind{n} = [];
    L{n} = 1;
    ni(n) = 0;
end
X = zeros(M); % coefficients
cond = 0; % this condition is true when ni(n)=s(n) for all n (all nonzero coefficients where computed)
posi = zeros(1,N); % additional index to add


% multiway cross correlation
B = double(ttensor(tensor(Y),transp(D)));

condchange = 1;
error = Inf;
% Main loop where selected indices in each mode are found
%Dred = D;
while ((condchange && (~cond) && (error > epsilon)))    
    niant = ni;
    proj = abs(double(ttensor(tensor(R),transp(D)))); % multiway correlation between dictionary and residual
     
    for n = 1:N
        [proj,v{n}] = max(abs(proj));
        add{n} = 1;
    end
     
    posi(N) = v{N};
    add{N} = posi(N);
    for n = N-1:-1:1        
        posi(n) = v{n}(add{:});
        add{n} = posi(n);
    end
    
    for n = 1:N
        if ((~ismember(posi(n),Ind{n})) && (ni(n) < s(n)))
        Ind{n} = [Ind{n},posi(n)];
        Dsub{n} = [Dsub{n},D{n}(:,posi(n))];
        ni(n) = ni(n) + 1;
            if ni(n) > 1
                w = L{n}\((D{n}(:,Ind{n}(1:ni(n) - 1)))'*D{n}(:,Ind{n}(ni(n))));
                L{n} = [L{n}, zeros(ni(n)-1,1); w', sqrt(1 - w'*w)];
            end         
        end
    end
    
    Z = B(Ind{:});
    

    for n = 1: N
        Z = L{n}\reshape(permute(Z,permorder(n,N)),[ni(n),prod(ni)/ni(n)]);
        Z = L{n}'\Z;
        Z = permute(reshape(Z,ni(permorder(n,N))),permorderinv(n,N));
    end
     Z = tensor(Z,ni);    
  
    R = Y - double(ttensor(Z,Dsub));
    error = norm(reshape(R,[I(1),prod(I)/I(1)]),'fro')/norma;
    disp([num2str(ni),'  ', num2str(error)])
    
    cond = 1;
    for n =1:N
        cond = cond && (ni(n) == s(n));
    end
    
    condchange = sum(ni-niant);
    
%     for n = 1:N
%         Dred{n}(:,Ind{n}(ni(n)))=0;
%     end
end

X(Ind{:}) = Z;
X=sptensor(X);

end

function [D] = transp(D)
N = size(D,2);
for n = 1:N
    D{n} = D{n}';
end
end

function [v] = permorder(n,N)
v = 1:N;
if n == 1 
    return;
end
v(1) = n;
for m = 1:n-1
    v(m+1) = m; 
end
end

function [v] = permorderinv(n,N)
v = 1:N;
if n == 1 
    return;
end
v(1:n-1) = 2:n;
v(n) = 1;

end

function [indx] = multi_index(M,pos)
N = size(M,2);
indx = zeros(1,N);
for n = N:-1:2
    indx(n) = floor(((pos - 1)/prod(M(1:n-1)))) + 1;
    pos = pos - (indx(n)-1)*prod(M(1:n-1));
end
indx(1) = pos;

end
