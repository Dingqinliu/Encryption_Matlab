%  本程序实现图像LENA的压缩传感
%  程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk
%  算法采用正交匹配法，参考文献 Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit，IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  该程序没有经过任何优化

function Wavelet_OMP

clc;clear

%  读文件
X=imread('lena256.bmp');
X=double(X);
[a,b]=size(X);

%  小波变换矩阵生成
ww=DWT(a);

%  小波变换让图像稀疏化（注意该步骤会耗费时间，但是会增大稀疏度）
X1=ww*sparse(X)*ww';
X1=full(X1);

%  随机矩阵生成
M=190;
R= PartHadamardMtx(M,a);

%  测量
Y=R*X1;

%  OMP算法
X2=zeros(a,b);  %  恢复矩阵
for i=1:b  %  列循环       
    rec=omp(Y(:,i),R,a);
    X2(:,i)=rec;
end


%  原始图像
figure(1);
imshow(uint8(X));


%  变换图像   %小波变换后的图像
figure(2);
imshow(uint8(X1));


%测量值图像
figure(3);
imshow(uint8(Y));


%  压缩传感恢复的图像
figure(4);
X3=ww'*sparse(X2)*ww;  %  小波反变换
X3=full(X3);
imshow(uint8(X3));


%  误差(PSNR)
errorx=sum(sum(abs(X3-X).^2));       %  MSE误差
psnr=10*log10(255*255/(errorx/a/b))   %  PSNR
 dNMSE = nmse(uint8(X),uint8(X3))   %NMSE误差

%  OMP的函数
%  s-测量；T-观测矩阵；N-向量大小
    %  重构的向量