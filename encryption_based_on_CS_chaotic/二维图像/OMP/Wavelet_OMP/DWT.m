%  �������ߣ�ɳ������۴�ѧ�������ӹ���ѧϵ��wsha@eee.hku.hk
%  �ο����ף�С������������MATLAB R2007ʵ�֣�����ѧ��ɳ������20��  С���任�ھ��󷽳�����е�Ӧ�ã�ɳ������������д��.

%  ��������С���任����ͼ���СN*N��N=2^P��P��������

function ww=DWT(N)

[h,g]= wfilters('sym8','d');       %  �ֽ��ͨ�͸�ͨ�˲���

% N=256;                           %  ����ά��(��СΪ2�������ݴ�)
L=length(h);                       %  �˲�������
rank_max=log2(N);                  %  ������
rank_min=double(int8(log2(L)))+1;  %  ��С����
ww=1;   %  Ԥ�������

%  ������
for jj=rank_min:rank_max
    
    nn=2^jj;
    
    %  ��������
    p1_0=sparse([h,zeros(1,nn-L)]);
    p2_0=sparse([g,zeros(1,nn-L)]);
    
    %  ����Բ����λ
    for ii=1:nn/2
        p1(ii,:)=circshift(p1_0',2*(ii-1))';
        p2(ii,:)=circshift(p2_0',2*(ii-1))';
    end
    
    %  ������������
    w1=[p1;p2];
    mm=2^rank_max-length(w1);
    w=sparse([w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)]);
    ww=ww*w;
    
    clear p1;clear p2;
end
