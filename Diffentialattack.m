clc;clear;close all;
tic;
nubLe=zeros(1,3);%nubBa=zeros(1,3);nubPe=zeros(1,3);
for i=1:20
M=192;N=256;
X=imread('peppers.bmp');
X=double(X);
[r,x0,x1,x2]=SHA256(X);
[C]=Encrypt1(X,r,x0,x1,x2,M,N);
    
ix=mod(floor(rand*10^8),M)+1;iy=mod(floor(rand*10^8),N)+1;
P1N=X;P1N(ix,iy)=mod(P1N(ix,iy)+1,256);
    %P2N=P2;P2N(ix,iy)=mod(P2N(ix,iy)+1,256);
    %P3N=P3;P3N(ix,iy)=mod(P3N(ix,iy)+1,256);
[r,x0,x1,x2]=SHA256(P1N);
[C1N]=Encrypt1(P1N,r,x0,x1,x2,M,N);%C2N=TpEncrypt(P2N,K);C3N=TpEncrypt(P3N,K);
nubLe=nubLe+NPCRUACIBACI(C,C1N);
    %nubBa=nubBa+NPCRUACIBACI(C2,C2N);
    %nubPe=nubPe+NPCRUACIBACI(C3,C3N);
end
nubLe=nubLe/20;%nubBa=nubBa/200;nubPe=nubPe/200;