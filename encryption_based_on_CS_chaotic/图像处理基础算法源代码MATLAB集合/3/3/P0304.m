I=imread('pout.tif');  % 读取MATLAB自带的potu.tif图像
imshow(I);
figure,imhist(I);     
[J,T]=histeq(I,64);      % 图像灰度扩展到0~255，但是只有64个灰度级
figure,imshow(J);
figure,imhist(J);
figure,plot((0:255)/255,T); % 转移函数的变换曲线
J=histeq(I,32);
figure,imshow(J);   % 图像灰度扩展到0~255，但是只有32个灰度级
figure,imhist(J);
