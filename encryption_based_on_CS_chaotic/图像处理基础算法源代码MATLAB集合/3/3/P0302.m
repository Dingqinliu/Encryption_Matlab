I=imread('cameraman.tif');           % MATLAB�Դ���ͼ����ͼ3-3��ʾ
imshow(I);
clear;close all 
I=imread('cameraman.tif');
imshow(I);
I=im2double(I);
T=dctmtx(8);
B=blkproc(I,[8 8], 'P1*x*P2',T,T');
Mask=[1 1 1 1 0 0 0 0
       1 1 1 0 0 0 0 0
       1 1 0 0 0 0 0 0
       1 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0];
B2=blkproc(B,[8 8],'P1.*x',Mask);    % �˴�Ϊ���(.*)
I2=blkproc(B2,[8 8], 'P1*x*P2',T',T);
figure,imshow(I2);                 % �ؽ����ͼ����ͼ3-4��ʾ
