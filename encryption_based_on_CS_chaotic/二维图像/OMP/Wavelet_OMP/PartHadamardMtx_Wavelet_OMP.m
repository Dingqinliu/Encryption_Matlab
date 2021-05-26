%  ������ʵ��ͼ��LENA��ѹ������
%  �������ߣ�ɳ������۴�ѧ�������ӹ���ѧϵ��wsha@eee.hku.hk
%  �㷨��������ƥ�䷨���ο����� Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit��IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  �ó���û�о����κ��Ż�

function Wavelet_OMP

clc;clear

%  ���ļ�
X=imread('lena256.bmp');
X=double(X);
[a,b]=size(X);

%  С���任��������
ww=DWT(a);

%  С���任��ͼ��ϡ�軯��ע��ò����ķ�ʱ�䣬���ǻ�����ϡ��ȣ�
X1=ww*sparse(X)*ww';
X1=full(X1);

%  �����������
M=190;
R= PartHadamardMtx(M,a);

%  ����
Y=R*X1;

%  OMP�㷨
X2=zeros(a,b);  %  �ָ�����
for i=1:b  %  ��ѭ��       
    rec=omp(Y(:,i),R,a);
    X2(:,i)=rec;
end


%  ԭʼͼ��
figure(1);
imshow(uint8(X));


%  �任ͼ��   %С���任���ͼ��
figure(2);
imshow(uint8(X1));


%����ֵͼ��
figure(3);
imshow(uint8(Y));


%  ѹ�����лָ���ͼ��
figure(4);
X3=ww'*sparse(X2)*ww;  %  С�����任
X3=full(X3);
imshow(uint8(X3));


%  ���(PSNR)
errorx=sum(sum(abs(X3-X).^2));       %  MSE���
psnr=10*log10(255*255/(errorx/a/b))   %  PSNR
 dNMSE = nmse(uint8(X),uint8(X3))   %NMSE���

%  OMP�ĺ���
%  s-������T-�۲����N-������С
    %  �ع�������