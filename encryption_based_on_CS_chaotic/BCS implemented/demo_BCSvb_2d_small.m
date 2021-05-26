%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，我这里提供分钱成品代码(′▽`〃)哦~登录淘宝店铺“大成软件工作室”便可领取
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了\(^o^)/YES!
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭～
%   传送门：https://shop305228693.taobao.com/?spm=a230r.7195193.1997079397.2.yVBY8j
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)
web https://shop305228693.taobao.com/?spm=a230r.7195193.1997079397.2.yVBY8j -browser

% Load original image -- image0
% image0: original 2-d image, resized to 32 x 32 from "indor2" with nearest neighbor interpolation  
I=imread('indor2.pgm');
I=double(I);
image0=imresize(I,[32,32]);

% 2D wavelet transformation and sparse signal -- theta0 
DecLevel=3;
WaveletName='db1';
[C0, S0] = wavedec2(image0, DecLevel, WaveletName);
theta0=C0(:);

%----------------------------------
% Projection matrix and observation
%----------------------------------

% Generate projection matrix Phi, N x M matrix
N = 600;    % number of CS measurements
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

image=waverec2(theta', S0, WaveletName);
ERR=sqrt(sum(sum((image-image0).^2,1),2)/sum(sum(image0.^2,1),2));

% ----
% plot
% ----

figure, subplot(2,2,1), imagesc(image0); colormap(gray); 
axis square; title('Original Image')
subplot(2,2,2); plot(theta0,'r')
axis([1,M,1.1*min(theta0), 1.1*max(theta0)]); title('Original Sparse Coefficients')
subplot(2,2,3); plot(theta);
axis([1,M,1.1*min(theta0), 1.1*max(theta0)]); title('Reconstructed Sparse Coefficients')
subplot(2,2,4); imagesc(image); colormap(gray);
axis square; title(['Recovered Image, rela err = ',num2str(ERR)])
