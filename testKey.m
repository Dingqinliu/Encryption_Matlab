clc;clear;close all
P1=imread('lenna.bmp');%P2=imread('lx2.jpg');P3=imread('timg.jpg');
P1=rgb2gray(P1);%P2=rgb2gray(P2);P3=rgb2gray(P3);
x0=rand(1,1000)*80-40;y0=rand(1,1000)*80-40;
z0=rand(1,1000)*80+1;w0=rand(1,1000)*500-250;
nubLex=zeros(1,3);nubLey=zeros(1,3);nubLez=zeros(1,3);nubLew=zeros(1,3);
%nubBax=zeros(1,3);nubBay=zeros(1,3);nubBaz=zeros(1,3);nubBaw=zeros(1,3);
%nubPex=zeros(1,3);nubPey=zeros(1,3);nubPez=zeros(1,3);nubPew=zeros(1,3);
for i=1:1000
K1=[x0(i) y0(i) z0(i) w0(i)];
CLe1=TpEncrypt(P1,K1);%CBa1=TpEncrypt(P2,K1);CPe1=TpEncrypt(P3,K1);
K2=[x0(i)+10^(-13) y0(i) z0(i) w0(i)];
CLe2=TpEncrypt(P1,K2);%CBa2=TpEncrypt(P2,K2);CPe2=TpEncrypt(P3,K2);
K3=[x0(i) y0(i)+10^(-13) z0(i) w0(i)];
CLe3=TpEncrypt(P1,K3);%CBa3=TpEncrypt(P2,K3);CPe3=TpEncrypt(P3,K3);
K4=[x0(i) y0(i) z0++10^(-13) w0(i)];
CLe4=TpEncrypt(P1,K4);%CBa4=TpEncrypt(P2,K4);CPe4=TpEncrypt(P3,K4);
K5=[x0(i) y0(i) z0(i) w0(i)+10^(-12)];
CLe5=TpEncrypt(P1,K5);%CBa5=TpEncrypt(P1,K5);CPe5=TpEncrypt(P1,K5);

nubLex=nubLex+NPCRUACIBACI(CLe1,CLe2);
nubLey=nubLey+NPCRUACIBACI(CLe1,CLe3);
nubLez=nubLez+NPCRUACIBACI(CLe1,CLe4);
nubLew=nubLew+NPCRUACIBACI(CLe1,CLe5);

% nubBax=nubBax+NPCRUACIBACI(CBa1,CBa2);
% nubBay=nubBay+NPCRUACIBACI(CBa1,CBa3);
% nubBaz=nubBaz+NPCRUACIBACI(CBa1,CBa4);
% nubBaw=nubBaw+NPCRUACIBACI(CBa1,CBa5);

% nubPex=nubPex+NPCRUACIBACI(CPe1,CPe2);
% nubPey=nubPey+NPCRUACIBACI(CPe1,CPe3);
% nubPez=nubPez+NPCRUACIBACI(CPe1,CPe4);
% nubPew=nubPew+NPCRUACIBACI(CPe1,CPe5);
end
nubLex=nubLex/1000;nubLey=nubLey/1000;nubLez=nubLez/1000;nubLew=nubLew/1000;
% nubBax=nubBax/1000;nubBay=nubBay/1000;nubBaz=nubBaz/1000;nubBaw=nubBaw/1000;
% nubPex=nubPex/1000;nubPey=nubPey/1000;nubPez=nubPez/1000;nubPew=nubPew/1000;