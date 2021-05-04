clear;clc;
P1=imread('Butterfly.png'); 
% PR1=P1;PG1=P1;PB1=P1;
% PR1(:,:,2)=0;PR1(:,:,3)=0;PG1(:,:,1)=0;PG1(:,:,3)=0;PB1(:,:,1)=0;PB1(:,:,2)=0;
P1=double(P1);
% PR1=P1(:,:,1);PG1=P1(:,:,2);PB1=P1(:,:,3);
[h,w]=size(P1);

P2=imread('1Butter.bmp'); 
P2=double(P2);
% PR2=P2(:,:,1);PG2=P2(:,:,2);PB2=P2(:,:,3);

B=8;
MAX=2^B-1;
MES=sum(sum((P1-P2).^2))/(h*w/3);
PSNR=10*log10(MAX.^2/MES);
ps1=PSNR(:,:,1)
ps2=PSNR(:,:,2)
ps3=PSNR(:,:,3)
ps=(ps1+ps2+ps3)/3
