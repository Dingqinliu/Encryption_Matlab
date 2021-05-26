%  本程序实现图像LENA的压缩传感
%  程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk
%  算法采用正交匹配法，参考文献 Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit，IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  该程序没有经过任何优化

function SparseRandomMtx_Wavelet_OMP

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
d=16;
R= SparseRandomMtx(M,a,d);

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
function hat_y=omp(s,T,N)

Size=size(T);                                     %  观测矩阵大小
M=Size(1);                                        %  测量
hat_y=zeros(1,N);                                 %  待重构的谱域(变换域)向量                     
Aug_t=[];                                         %  增量矩阵(初始值为空矩阵)
r_n=s;                                            %  残差值

for times=1:M/4;                                  %  迭代次数(稀疏度是测量的1/4)
    for col=1:N;                                  %  恢复矩阵的所有列向量
        product(col)=abs(T(:,col)'*r_n);          %  恢复矩阵的列向量和残差的投影系数(内积值) 
    end
    [val,pos]=max(product);                       %  最大投影系数对应的位置
    Aug_t=[Aug_t,T(:,pos)];                       %  矩阵扩充
    T(:,pos)=zeros(M,1);                          %  选中的列置零（实质上应该去掉，为了简单我把它置零）
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  最小二乘,使残差最小
    r_n=s-Aug_t*aug_y;                            %  残差
    pos_array(times)=pos;                         %  纪录最大投影系数的位置
    
    if (norm(r_n)<9)                              %  残差足够小
        break;
    end
end
hat_y(pos_array)=aug_y;                           %  重构的向量