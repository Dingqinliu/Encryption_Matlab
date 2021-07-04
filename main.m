clear;
close all;
clc;
P1=imread('lena.bmp');
M=256;N=256;
P2 = zeros(M, N);%ȫ��ͼ
P3 = ones(M, N) * 255;%ȫ��ͼ
iptsetpref( 'imshowborder', 'tight');

%%����
K= [0.4563,0.7865,0.9721,0.4242,99,164,79,214];%����� �������
tic; %tic��toc�ǴӲ�ӽ���ʱ�� ����ע��toc��λ�� 
[X,Y,R,W] = PRICKeyGen(P1,K);
C1= PRICEnc(P1,X, Y, R, W,K);
toc;
C2 = PRICEnc(P2,X, Y, R, W, K);C3 = PRICEnc(P3,X,Y,R,W,K);

%%��ʾ����ͼ��
figure(1); imshow( uint8(C1));
figure(2); imshow( uint8(C2));
figure(3); imshow( uint8(C3));

%%�����Ǽ��ܵ������
tic;
[X,Y,R,W] = PRICKeyGen(C1,K);
P11 = PRICDec(C1,X,Y,R,W,K);
toc;
P21 = PRICDec(C2,X,Y,R,W,K);
P31 = PRICDec(C3,X, Y,R, W,K);

%%��ʾ���ܺ��ͼ��
figure(4); imshow(uint8(P11));
figure(5); imshow(uint8(P21));
figure(6); imshow(uint8(P31));

