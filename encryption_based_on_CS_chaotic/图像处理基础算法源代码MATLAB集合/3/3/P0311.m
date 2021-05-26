I=imread('Saturn.tif');
imshow(I);
J1=imnoise(I,'salt & pepper');   % 叠加椒盐噪声
figure,imshow(J1);
f=double(J1);     % 数据类型转换，MATLAB不支持图像的无符号整型的计算
g=fft2(f);        % 傅立叶变换
g=fftshift(g);     % 转换数据矩阵
[M,N]=size(g);
nn=2;           % 二阶巴特沃斯(Butterworth)低通滤波器
d0=50;
m=fix(M/2); n=fix(N/2);
for i=1:M
       for j=1:N
           d=sqrt((i-m)^2+(j-n)^2);
           h=1/(1+0.414*(d/d0)^(2*nn));  % 计算低通滤波器传递函数
           result(i,j)=h*g(i,j);
       end
end
result=ifftshift(result);
J2=ifft2(result);
J3=uint8(real(J2));
figure,imshow(J3);                      % 显示滤波处理后的图像
