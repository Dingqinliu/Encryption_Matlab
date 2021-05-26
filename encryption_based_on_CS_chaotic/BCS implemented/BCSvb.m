%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，我这里提供分钱成品代码(′▽`〃)哦~登录淘宝店铺“大成软件工作室”便可领取
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了\(^o^)/YES!
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭～
%   传送门：https://shop305228693.taobao.com/?spm=a230r.7195193.1997079397.2.yVBY8j
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)

function [theta, posterior, bound]=BCSvb(Phi, v, hyperpara, niter, tol, plotflag)
%BCSvb: Bayesian CS inversion implemented by variational Bayes.
%USAGE: [theta, posterior, bound]=BCSvb(Phi, v, hyperpara, niter, tol, plotflag)
%INPUT (number in [] means default value):  
%   Phi: N x M, CS projection matrix
%   v: N x 1, CS observation
%   hyperpara: VB hyperparameters
%       hyperpara.a0: scalar, hyperparameter 1 for noise precision [1e-6]
%       hyperpara.b0: scalar, hyperparameter 2 for noise precision [1e-6]
%       hyperpara.c0: scalar, hyperparameter 1 for non-zero coefficients precision [1e-6] 
%       hyperpara.d0: scalar, hyperparameter 2 for non-zero coefficients precision [1e-6] 
%   niter: scalar, maximum number of VB iterations [100]
%   tol: scalar, tolarance of relative change of VB lower bound for two consecutive steps [1e-4] 
%   plotflag: indicator, one means plotting result for each iteration, zero means no plot [0] 
%OUTPUT:
%   theta: M x 1, mean of reconstructed signal
%   posterior: hyperparameter for posterior distribution
%       posterior.MUtheta: M x 1, mean of inverted theta 
%       posterior.VARtheta_diag: M x 1, variance of inverted theta (for each coefficient)
%       posterior.a: scalar, posterior hyperparameter 1 for noise precision
%       posterior.b: scalar, posterior hyperparameter 2 for noise precision
%       posterior.c: M x 1, posterior hyperparameter 1 for coefficient precision
%       posterior.d: M x 1, posterior hyperparameter 2 for coefficient precision
%   bound: 1 x (number of VB iterations), VB lower bound for each iteration

%--------------------------------------------------------------------------
% References:
% S.Ji, Y.Xue and L.Carin, "Bayesian Compressive Sesning" (2007).
% L.He and L.Carin, "Exploiting Structure in Wavelet-Based Bayesian Compressive Sensing" (2008)  
%
% Lihan He, ECE, Duke University
% Created: Nov. 21, 2008
% Last change: Mar. 3, 2009, allowing [] for input arguments (using default value)
%--------------------------------------------------------------------------

% ---------------------
% check input arguments
% ---------------------

if nargin<6, plotflag=0; end
if nargin<5, tol=1e-4; end
if nargin<4, niter=100; end
if nargin<3
    hyperpara.a0=1e-6;
    hyperpara.b0=1e-6;
    hyperpara.c0=1e-6;
    hyperpara.d0=1e-6;
end

if isempty(hyperpara)
    hyperpara.a0=1e-6;
    hyperpara.b0=1e-6;
    hyperpara.c0=1e-6;
    hyperpara.d0=1e-6;
end
if isempty(niter), niter=100; end
if isempty(tol), tol=1e-4; end
if isempty(plotflag), plotflag=0; end

a0=hyperpara.a0;
b0=hyperpara.b0;
c0=hyperpara.c0;
d0=hyperpara.d0;

[N,M] = size(Phi);  % N - number of CS measurements; M - sparse signal length

% --------------
% Initialization
% --------------

MUtheta=zeros(M,1);
VARtheta_diag=d0/c0*ones(M,1);

c=c0*ones(M,1);
d=d0*ones(M,1);

a=a0;
b=b0;

%---------------
% precomputation
%---------------
Phiv=Phi'*v;

% ------------
% VB iteration
% ------------

iter=0;
curr_lb=2*tol+1;
last_lb=1;
while iter<niter & abs((curr_lb-last_lb)/last_lb)>tol
    
    iter=iter+1;

    % (1) alpha
    c=c0+0.5;
    d=d0+0.5*(VARtheta_diag+MUtheta.^2);
    
    % (2) theta
    invA=d./c;
    CC=Phi.*repmat(invA',[N,1]);
    DD=inv(eye(N)*b/a+CC*Phi');
    MUtheta=a/b*(invA.*Phiv-CC'*(DD*(CC*Phiv)));
    VARtheta_diag=invA-sum((DD*CC).*CC,1)';   % Minhua's
    
    % (3) alpha0
    alpha0inv=b/a;
    res=alpha0inv*(DD*v);
    tmp=N*alpha0inv-alpha0inv*alpha0inv*sum(diag(DD));
    a=a0+0.5*N;
    b=b0+0.5*(res'*res+tmp);
    
    % lower bound
    J1=-N/2*log(2*pi)+N/2*(psi(a)-log(b))-(a/b)*(b-b0);
    J2=-M/2*log(2*pi)+0.5*sum(psi(c)-log(d)-(c./d).*(VARtheta_diag+MUtheta.^2),1);
    [LL,UU]=lu(DD);
    logdetVARtheta=real(sum(log(diag(UU)),1))+sum(log(invA),1)+N*log(b/a);
    J3=M/2*(log(2*pi)+1)+0.5*logdetVARtheta;
    J4=-(a*log(b)-a0*log(b0)-gammaln(a)+gammaln(a0)+(a-a0)*(psi(a)-log(b))-a*(1-b0/b));
    J5=-sum(c.*log(d)-c0.*log(d0)-gammaln(c)+gammaln(c0)+(c-c0).*(psi(c)-log(d))-c.*(1-d0./d),1);
    J=J1+J2+J3+J4+J5;
    bound(iter)=J;
    last_lb=curr_lb;
    curr_lb=J;
  
    fprintf('Iteration %d: VB lower bound = %f.\n',iter,bound(iter));
    
    % plot
    if plotflag
        figure(1000), plot(MUtheta,'.'); axis([0,M+1,1.1*min(MUtheta),1.1*max(MUtheta)]); 
        xlabel('Coefficient Index'); ylabel('Coefficient Value')
        title(['Iteration',int2str(iter),':  mean inverted signal']);
        pause(0.001);
    end

end

% ---------------
% Result & output
% ---------------

theta=MUtheta;

posterior.MUtheta=MUtheta;
posterior.VARtheta_diag=VARtheta_diag;
posterior.a=a;
posterior.b=b;
posterior.c=c;
posterior.d=d;
