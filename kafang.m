clc;clear;close all;
K=[1.1 2.2 3.3 4.4];
P=imread('lenna.bmp');
% P2=imread('Green.bmp');P3=imread('Blue.bmp');
 P1=rgb2gray(P);
%  P2=rgb2gray(P2);P3=rgb2gray(P3);

% P_R1=P;P_G1=P;P_B1=P;tic;
% P_R1(:,:,2)=0;P_R1(:,:,3)=0;P_G1(:,:,1)=0;P_G1(:,:,3)=0;P_B1(:,:,1)=0;P_B1(:,:,2)=0;
% P=double(P);P_R=P(:,:,1);P_G=P(:,:,2);P_B=P(:,:,3);
% % imhist(uint8(P(:,:,1)));


P1=double(P1);
% P2=double(P2);P3=double(P3);
iptsetpref('imshowborder','tight');

figure(1);imshow(P1);
% figure(2);imshow(P2);figure(3);imshow(P3);
% figure(1);imshow(uint8(P(:,:,1)));figure(2);imshow(uint8(P_G));figure(3);imshow(P_B);
% C1=TpEncrypt(P1,K);C2=TpEncrypt(P2,K);C3=TpEncrypt(P3,K);
% figure(4);imshow(C1);figure(5);imshow(C2);figure(6);imshow(C3);

% P1=double(P1);P2=double(P2);P3=double(P3);
figure(7);
hist(P1(:),256);set(gca,'fontsize',18);
% hist(P_R,256);set(gca,'fontsize',18);
% figure(8);hist(P2(:),256);set(gca,'fontsize',18);
% figure(9);hist(P3(:),256);set(gca,'fontsize',18);
% C1=double(C1);C2=double(C2);C3=double(C3);
% figure(10);hist(C1(:),256);set(gca,'fontsize',18);
% figure(11);hist(C2(:),256);set(gca,'fontsize',18);
% figure(12);hist(C3(:),256);set(gca,'fontsize',18);

[M,N]=size(P1);g=M*N/256;
 fp1=hist(P1(:),256);
%  fp2=hist(P2(:),256);fp3=hist(P3(:),256);
% fp1=hist(P_R,256);
% fp2=hist(P2(:),256);fp3=hist(P3(:),256);
chai1=sum((fp1-g).^2)/g;
% chai2=sum((fp2-g).^2)/g;chai3=sum((fp3-g).^2)/g;
% fc1=hist(C1(:),256);fc2=hist(C2(:),256);fc3=hist(C3(:),256);
% chai4=sum((fc1-g).^2)/g;chai5=sum((fc2-g).^2)/g;chai6=sum((fc3-g).^2)/g;