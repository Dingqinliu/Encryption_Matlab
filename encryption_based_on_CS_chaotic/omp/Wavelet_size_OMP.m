%? 本程序实现图像LENA的压缩传感

%? 程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk

%? 算法采用正交匹配法，参考文献 Joel A. Tropp and Anna C. Gilbert

%? Signal Recovery From Random Measurements Via Orthogonal Matching

%? Pursuit，IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,

%? DECEMBER 2007.

%? 该程序没有经过任何优化

%function Wavelet_OMP

clc

clear

%? 读文件

X=imread('c:/图像/lena.tiff');
X=rgb2gray(X);
X=double(X);

[a,b]=size(X);

size_kuai=1*16;

X2=zeros(size_kuai);%? 恢复矩阵

X3=zeros(a,b);%? 恢复矩阵

%? 小波变换矩阵生成

ww=DWT(size_kuai);

%? 随机矩阵生成

M=12*4;

R=randn(M,size_kuai);

tic

for i_x=1:ceil(a/size_kuai)

for i_y=1:ceil(b/size_kuai)

XX=X((i_x-1)*size_kuai+1:i_x*size_kuai,(i_y-1)*size_kuai+1:i_y*size_kuai);

%? 小波变换让图像稀疏化（注意该步骤会耗费时间，但是会增大稀疏度）

X1=ww*sparse(XX)*ww';

X1=full(X1);

%? 测量

Y=R*X1;

%? OMP算法

for i=1:size_kuai %? 列循环? ? ?

rec=omp_fenkuai(Y(:,i),R,size_kuai);

X2(:,i)=rec;

end

X3((i_x-1)*size_kuai+1:i_x*size_kuai,(i_y-1)*size_kuai+1:i_y*size_kuai)=ww'*sparse(X2)*ww;%? 小波反变换

end

end

X3=full(X3);

use_time=toc

%? 原始图像

figure(1);

imshow(uint8(X));

title('原始图像');

%? 压缩传感恢复的图像

figure(2);

imshow(uint8(X3));

title('分块恢复的图像');

%? 误差(PSNR)

errorx=sum(sum(abs(X3-X).^2)); %? MSE误差

psnr=10*log10(255*255/(errorx/a/b))%? PSNR

%? OMP的函数

%? s-测量；T-观测矩阵；N-向量大小

function hat_y=omp_fenkuai(s,T,N)

Size=size(T);%? 观测矩阵大小

M=Size(1); %? 测量

hat_y=zeros(1,N); %? 待重构的谱域(变换域)向量? ? ? ? ? ? ? ? ? ?

Aug_t=[]; %? 增量矩阵(初始值为空矩阵)

r_n=s; %? 残差值

for times=1:M/4 %? 迭代次数(稀疏度是测量的1/4)

for col=1:N %? 恢复矩阵的所有列向量

product(col)=abs(T(:,col)'*r_n); %? 恢复矩阵的列向量和残差的投影系数(内积值)

end

[val,pos]=max(product); %? 最大投影系数对应的位置

Aug_t=[Aug_t,T(:,pos)]; %? 矩阵扩充

T(:,pos)=zeros(M,1); %? 选中的列置零（实质上应该去掉，为了简单我把它置零）

aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;%? 最小二乘,使残差最小

r_n=s-Aug_t*aug_y; %? 残差

pos_array(times)=pos; %? 纪录最大投影系数的位置

if (norm(r_n)<40) %? 残差足够小

break;

end

end

hat_y(pos_array)=aug_y; %? 重构的向量
end
%? 程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk

%? 参考文献：小波分析理论与MATLAB R2007实现，葛哲学，沙威，第20章? 小波变换在矩阵方程求解中的应用（沙威、陈明生编写）.

%? 构造正交小波变换矩阵，图像大小N*N，N=2^P，P是整数。

function ww=DWT(N)

[h,g]= wfilters('sym8','d'); %? 分解低通和高通滤波器

% N=256;? ? ? ? ? ? ? ? ? ? ? ? ? %? 矩阵维数(大小为2的整数幂次)

L=length(h);%? 滤波器长度

rank_max=log2(N);%? 最大层数

rank_min=double(int8(log2(L)))+1; %? 最小层数

ww=1; %? 预处理矩阵

%? 矩阵构造

for jj=rank_min:rank_max

nn=2^jj;

%? 构造向量

p1_0=sparse([h,zeros(1,nn-L)]);

p2_0=sparse([g,zeros(1,nn-L)]);

%? 向量圆周移位

for ii=1:nn/2

p1(ii,:)=circshift(p1_0',2*(ii-1))';

p2(ii,:)=circshift(p2_0',2*(ii-1))';

end

%? 构造正交矩阵

w1=[p1;p2];

mm=2^rank_max-length(w1);

w=sparse([w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)]);

ww=ww*w;

clear p1;clear p2;

end
end