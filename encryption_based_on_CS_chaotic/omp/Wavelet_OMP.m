%   ��л����ʹ�ô˴��룬�˴�����������������~(@^_^@)~
%   û����Ļ���������һ������Ϣ����¼�Ա����̡������������ҡ�����������(????)1��Ǯ��Ʒ����(�䨌`��)Ŷ~
%   �ǵģ��������û�п�������ͷƤ���������1��Ǯ�Ϳ��Խ����(��??????)��
%   С����ͰѴ����Ÿ������ǵ�Ҫ�ղغ�Ŷ(�ţ�3��)�Ũq?��
%   �����ţ�https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   ���������ʧЧ�����׿�����������Ҫ���ͷ�MM��������ɧ��Ŷ~(*/�بv*)
function Wavelet_OMP

clc;clear

%  ���ļ�
X=imread('lena.bmp');
X=double(X);
[a,b]=size(X);

%  С���任��������
ww=DWT(a);

%  С���任��ͼ��ϡ�軯��ע��ò����ķ�ʱ�䣬���ǻ�����ϡ��ȣ�
X1=ww*sparse(X)*ww';
X1=full(X1);

%  �����������
M=190;
R=randn(M,a);

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
title('ԭʼͼ��');

%  �任ͼ��
figure(2);
imshow(uint8(X1));
title('С���任���ͼ��');

%  ѹ�����лָ���ͼ��
figure(3);
X3=ww'*sparse(X2)*ww;  %  С�����任
X3=full(X3);
imshow(uint8(X3));
title('�ָ���ͼ��');

%  ���(PSNR)
errorx=sum(sum(abs(X3-X).^2));        %  MSE���
psnr=10*log10(255*255/(errorx/a/b))   %  PSNR


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
