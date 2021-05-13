clc;clear;close all;
P=imread('lena.jpg');
P=rgb2gray(P);
figure(1);imshow(P);
K=[0.13 0.55 0.25 0.52 0.32];
C=TLENCRYPTEx(P,K,1,1);
figure(2);imshow(uint8(C));
% for i=1:256
%     for j=1:512
% 
%           C(j,i)=0;
%     end
% end
% 
% figure(2);imshow(uint8(C));
% P1=TLDECRYPTEx(C,K,1,1);
% figure(4);imshow(uint8(P1));


