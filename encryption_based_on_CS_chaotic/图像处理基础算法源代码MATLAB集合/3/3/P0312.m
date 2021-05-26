I=imread('blood1.tif');
imshow(I);
f=double(I);     % 数据类型转换，MATLAB不支持图像的无符号整型的计算
g=fft2(f);        % 傅立叶变换
g=fftshift(g);     % 转换数据矩阵
[M,N]=size(g);
nn=2;           % 二阶巴特沃斯(Butterworth)高通滤波器
d0=5;
m=fix(M/2);
n=fix(N/2);
for i=1:M
       for j=1:N
           d=sqrt((i-m)^2+(j-n)^2);
           if (d==0)
              h=0;
           else
              h=1/(1+0.414*(d0/d)^(2*nn));% 计算传递函数
           end
result(i,j)=h*g(i,j);
end
end
result=ifftshift(result);
J2=ifft2(result);
J3=uint8(real(J2));
figure,imshow(J3);  % 滤波后图像显示
