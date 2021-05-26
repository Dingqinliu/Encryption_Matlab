%? ������ʵ��ͼ��LENA��ѹ������

%? �������ߣ�ɳ������۴�ѧ�������ӹ���ѧϵ��wsha@eee.hku.hk

%? �㷨��������ƥ�䷨���ο����� Joel A. Tropp and Anna C. Gilbert

%? Signal Recovery From Random Measurements Via Orthogonal Matching

%? Pursuit��IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,

%? DECEMBER 2007.

%? �ó���û�о����κ��Ż�

%function Wavelet_OMP

clc

clear

%? ���ļ�

X=imread('c:/ͼ��/lena.tiff');
X=rgb2gray(X);
X=double(X);

[a,b]=size(X);

size_kuai=1*16;

X2=zeros(size_kuai);%? �ָ�����

X3=zeros(a,b);%? �ָ�����

%? С���任��������

ww=DWT(size_kuai);

%? �����������

M=12*4;

R=randn(M,size_kuai);

tic

for i_x=1:ceil(a/size_kuai)

for i_y=1:ceil(b/size_kuai)

XX=X((i_x-1)*size_kuai+1:i_x*size_kuai,(i_y-1)*size_kuai+1:i_y*size_kuai);

%? С���任��ͼ��ϡ�軯��ע��ò����ķ�ʱ�䣬���ǻ�����ϡ��ȣ�

X1=ww*sparse(XX)*ww';

X1=full(X1);

%? ����

Y=R*X1;

%? OMP�㷨

for i=1:size_kuai %? ��ѭ��? ? ?

rec=omp_fenkuai(Y(:,i),R,size_kuai);

X2(:,i)=rec;

end

X3((i_x-1)*size_kuai+1:i_x*size_kuai,(i_y-1)*size_kuai+1:i_y*size_kuai)=ww'*sparse(X2)*ww;%? С�����任

end

end

X3=full(X3);

use_time=toc

%? ԭʼͼ��

figure(1);

imshow(uint8(X));

title('ԭʼͼ��');

%? ѹ�����лָ���ͼ��

figure(2);

imshow(uint8(X3));

title('�ֿ�ָ���ͼ��');

%? ���(PSNR)

errorx=sum(sum(abs(X3-X).^2)); %? MSE���

psnr=10*log10(255*255/(errorx/a/b))%? PSNR

%? OMP�ĺ���

%? s-������T-�۲����N-������С

function hat_y=omp_fenkuai(s,T,N)

Size=size(T);%? �۲�����С

M=Size(1); %? ����

hat_y=zeros(1,N); %? ���ع�������(�任��)����? ? ? ? ? ? ? ? ? ?

Aug_t=[]; %? ��������(��ʼֵΪ�վ���)

r_n=s; %? �в�ֵ

for times=1:M/4 %? ��������(ϡ����ǲ�����1/4)

for col=1:N %? �ָ����������������

product(col)=abs(T(:,col)'*r_n); %? �ָ�������������Ͳв��ͶӰϵ��(�ڻ�ֵ)

end

[val,pos]=max(product); %? ���ͶӰϵ����Ӧ��λ��

Aug_t=[Aug_t,T(:,pos)]; %? ��������

T(:,pos)=zeros(M,1); %? ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼��Ұ������㣩

aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;%? ��С����,ʹ�в���С

r_n=s-Aug_t*aug_y; %? �в�

pos_array(times)=pos; %? ��¼���ͶӰϵ����λ��

if (norm(r_n)<40) %? �в��㹻С

break;

end

end

hat_y(pos_array)=aug_y; %? �ع�������
end
%? �������ߣ�ɳ������۴�ѧ�������ӹ���ѧϵ��wsha@eee.hku.hk

%? �ο����ף�С������������MATLAB R2007ʵ�֣�����ѧ��ɳ������20��? С���任�ھ��󷽳�����е�Ӧ�ã�ɳ������������д��.

%? ��������С���任����ͼ���СN*N��N=2^P��P��������

function ww=DWT(N)

[h,g]= wfilters('sym8','d'); %? �ֽ��ͨ�͸�ͨ�˲���

% N=256;? ? ? ? ? ? ? ? ? ? ? ? ? %? ����ά��(��СΪ2�������ݴ�)

L=length(h);%? �˲�������

rank_max=log2(N);%? ������

rank_min=double(int8(log2(L)))+1; %? ��С����

ww=1; %? Ԥ�������

%? ������

for jj=rank_min:rank_max

nn=2^jj;

%? ��������

p1_0=sparse([h,zeros(1,nn-L)]);

p2_0=sparse([g,zeros(1,nn-L)]);

%? ����Բ����λ

for ii=1:nn/2

p1(ii,:)=circshift(p1_0',2*(ii-1))';

p2(ii,:)=circshift(p2_0',2*(ii-1))';

end

%? ������������

w1=[p1;p2];

mm=2^rank_max-length(w1);

w=sparse([w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)]);

ww=ww*w;

clear p1;clear p2;

end
end