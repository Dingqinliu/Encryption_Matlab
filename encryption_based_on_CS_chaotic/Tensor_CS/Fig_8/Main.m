%% Written by C. Caiafa, 2013.
%% email: ccaiafa@gmail.com (http://web.fi.uba.ar/~ccaiafa/Cesar/Cesar.html)

%% Hyperspectral Compressive Sampling Imaging results.
% This Matlab Code generates the results shown in Fig 8 (case with sampling ratio=33%) in the paper 
% "Multidimensional Compressed Sensing and its Applications", by C. Caiafa
% and A. Cichocki, submitted to Wiley Interdisciplinary Reviews: Data
% Mining and Knowledge Discovery (2013)

% Block-sparsity is assumed on a separable (Kronecker) orthogonal basis given by the Daubechies WT. 
% A random (Gaussian) separable 2D operator was used for sensing every slice of the hyperspectral cube 
% 1024x1024x32.The reconstruction was obtained by applied the NBOMP
% algorithm on the 3D compressive signal Z

% This demo requires to have the following packages installed:
% - MATLAB Tensor Toolbox Version 2.4, Brett W. Bader and Tamara G. Kolda,  
% available at http://csmr.ca.sandia.gov/~tgkolda/TensorToolbox/, March 2010.


%% This code takes about 90 minutes to run in a notebook computer (MacBookPro, 2.3GHz)
%% To generate Fig 8 just call MakeFig8() which displays the saved results (case sampling ratio=33%)
clear
clc

load ../Datasets/Hyperspectral/ref_cyflower1bb_reg1.mat
I0 = zeros(1024,1024,32);
I0(1:1017,:,:) = reflectances(1:1017,1:1024,2:33);
clear 'reflectances'

I = size(I0);

K = [1.75, 1.75, 1];
M = round([I(1)/K(1), I(2)/K(2), I(3)/K(3)]);

epsilon = 0.02;
 
load WTbases; % load Daubechies WT bases

% Define sensing matrices
SM1 = normalize(randn(M(1),I(1)));
SM2 = normalize(randn(M(2),I(2)));
SM3 = eye(I(3),I(3));

Y = double(ttensor(tensor(I0),{SM1,SM2,SM3})); % Compressive measurement

D0{1} = normalize(SM1*W{1}');      
D0{2} = normalize(SM2*W{2}');
D0{3} = normalize(SM3*W{3}');

% Compute NBOMP
disp('Computing block-sparse representation using Tensor-OMP...')
tic
[Test, Ind] = tensor_OMPND(D0,Y,I,epsilon);
TimetensorOMP = toc;

Z=Test(Ind{:});

Trunc = zeros(I);
Trunc(Ind{1},Ind{2},Ind{3}) = Z;

AproxtensorOMP = ttensor(tensor(Trunc),{W{1}',W{2}',W{3}'});

AproxtensorOMP = double(AproxtensorOMP)/norm(AproxtensorOMP);
I0 = I0/norm(tensor(I0));

errortensorOMP = norm(tensor(I0 - AproxtensorOMP))

PSNRtensorOMP = 20*log10(max(I0(:))/sqrt(mean((I0(:) - AproxtensorOMP(:)).^2)))

samplingratio = prod(size(Y))/prod(I);

save BOMPresults33.mat

%% Produce Fig 8 (case sampling ratio=33%)
MakeFig8()



