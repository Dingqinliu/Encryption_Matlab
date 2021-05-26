I=imread('blood1.tif');
imhist(I);          % 观察灰度直方图， 灰度140处有谷，确定阈值T=140
I1=im2bw(I,140/255); % im2bw函数需要将灰度值转换到[0,1]范围内
figure,imshow(I1);
