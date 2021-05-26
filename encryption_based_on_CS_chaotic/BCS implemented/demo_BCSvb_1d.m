%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，我这里提供分钱成品代码(′▽`〃)哦~登录淘宝店铺“大成软件工作室”便可领取
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了\(^o^)/YES!
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭～
%   传送门：https://shop305228693.taobao.com/?spm=a230r.7195193.1997079397.2.yVBY8j
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)
web https://shop305228693.taobao.com/?spm=a230r.7195193.1997079397.2.yVBY8j -browser

% Generate original step signal -- signal0
% signal0: random generated step signal with random step position, step
% width and step amplitude
Nsignal=512;    % signal length
Nstep=10;       % number of steps in the entire signal 
maxWstep=30;    % max width of each step 
Astep=1;        % approximate amplitude region of each step 
q = randperm(Nsignal);
Tstep=q(1:Nstep);       % random step position
Wstep=round(rand(1,Nstep)*maxWstep);    % random step width
Wstep_l=Tstep-round(Wstep/2);
Wstep_r=Wstep_l+Wstep;
signal0=zeros(1,Nsignal);
for i=1:Nstep
    idx=max(1,Wstep_l(i)):min(Nsignal,Wstep_r(i));
    signal0(idx)=signal0(idx)+Astep*randn*ones(1,length(idx));
end

% 1D wavelet transformation and sparse signal -- theta0 
DecLevel=6;
WaveletName='db1';
[C0, S0] = wavedec(signal0, DecLevel, WaveletName);
theta0=C0(:);

%----------------------------------
% Projection matrix and observation
%----------------------------------

% Generate projection matrix Phi, N x M matrix
N = 150;    % number of CS measurements
M = length(theta0);
Phi = randn(N,M);
Phi = Phi./repmat(sqrt(sum(Phi.^2,1)),[N,1]);	

% CS observations
v = Phi*theta0;

%----------------------
% CS inversion by BCSvb
%----------------------

theta = BCSvb(Phi, v);
% "[]" can be used as input arguments for default values, e.g.,
% theta = BCSvb(Phi, v, [], [], [], 1);

%---------------------
% Reconstruction error
% --------------------

signal=waverec(theta', S0, WaveletName);
ERR=sqrt(sum((signal-signal0).^2,1)/sum(signal0.^2,1));

% ----
% plot
% ----

figure, subplot(2,2,1), plot(signal0,'r'); 
axis([1,M,1.1*min(signal0), 1.1*max(signal0)]); title('Original Signal')
subplot(2,2,2); plot(theta0,'r')
axis([1,M,1.1*min(theta0), 1.1*max(theta0)]); title('Original Sparse Coefficients')
subplot(2,2,3); plot(theta);
axis([1,M,1.1*min(theta0), 1.1*max(theta0)]); title('Reconstructed Sparse Coefficients')
subplot(2,2,4); plot(signal);
axis([1,M,1.1*min(signal0), 1.1*max(signal0)]); title(['Recovered Signal, rela err = ',num2str(ERR)])
