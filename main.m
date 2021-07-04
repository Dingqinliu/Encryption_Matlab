clear;
close all;
clc;
P1=imread('lena.bmp');
M=256;N=256;
P2 = zeros(M, N);%全黑图
P3 = ones(M, N) * 255;%全白图
iptsetpref( 'imshowborder', 'tight');

%%加密
K= [0.4563,0.7865,0.9721,0.4242,99,164,79,214];%随机数 随机设置
tic; %tic和toc是从测加解密时间 这里注意toc的位置 
[X,Y,R,W] = PRICKeyGen(P1,K);
C1= PRICEnc(P1,X, Y, R, W,K);
toc;
C2 = PRICEnc(P2,X, Y, R, W, K);C3 = PRICEnc(P3,X,Y,R,W,K);

%%显示密文图像
figure(1); imshow( uint8(C1));
figure(2); imshow( uint8(C2));
figure(3); imshow( uint8(C3));

%%解密是加密的逆过程
tic;
[X,Y,R,W] = PRICKeyGen(C1,K);
P11 = PRICDec(C1,X,Y,R,W,K);
toc;
P21 = PRICDec(C2,X,Y,R,W,K);
P31 = PRICDec(C3,X, Y,R, W,K);

%%显示解密后的图像
figure(4); imshow(uint8(P11));
figure(5); imshow(uint8(P21));
figure(6); imshow(uint8(P31));

