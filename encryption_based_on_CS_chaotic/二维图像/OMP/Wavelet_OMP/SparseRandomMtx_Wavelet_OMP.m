%  ������ʵ��ͼ��LENA��ѹ������
%  �������ߣ�ɳ������۴�ѧ�������ӹ���ѧϵ��wsha@eee.hku.hk
%  �㷨��������ƥ�䷨���ο����� Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit��IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  �ó���û�о����κ��Ż�

function SparseRandomMtx_Wavelet_OMP

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
d=16;
R= SparseRandomMtx(M,a,d);

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
function hat_y=omp(s,T,N)

Size=size(T);                                     %  �۲�����С
M=Size(1);                                        %  ����
hat_y=zeros(1,N);                                 %  ���ع�������(�任��)����                     
Aug_t=[];                                         %  ��������(��ʼֵΪ�վ���)
r_n=s;                                            %  �в�ֵ

for times=1:M/4;                                  %  ��������(ϡ����ǲ�����1/4)
    for col=1:N;                                  %  �ָ����������������
        product(col)=abs(T(:,col)'*r_n);          %  �ָ�������������Ͳв��ͶӰϵ��(�ڻ�ֵ) 
    end
    [val,pos]=max(product);                       %  ���ͶӰϵ����Ӧ��λ��
    Aug_t=[Aug_t,T(:,pos)];                       %  ��������
    T(:,pos)=zeros(M,1);                          %  ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼��Ұ������㣩
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  ��С����,ʹ�в���С
    r_n=s-Aug_t*aug_y;                            %  �в�
    pos_array(times)=pos;                         %  ��¼���ͶӰϵ����λ��
    
    if (norm(r_n)<9)                              %  �в��㹻С
        break;
    end
end
hat_y(pos_array)=aug_y;                           %  �ع�������