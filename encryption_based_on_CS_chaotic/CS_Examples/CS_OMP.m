
%%%%%%%%%%%%% ����Ƶ�����ҵ����ź� ���Ƿ���� ѹ����֪�ָ�(OMP�㷨) %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% ������ѧ������ѧ ��� 2011.03 %%%%%%%%%%%%%%%%%%%%

clear;

Tend=6; % �źų���ʱ�� 0-Tend
fs=200; % ԭʼ���β���Ƶ��
tt1=0:1/fs:Tend; % ԭʼ���β���ʱ���
N=size(tt1,2); % �������� 
f1=13; % �����ź�Ƶ��
f2=5;
f3=2;
y1=cos(2*pi*f1*tt1)+cos(2*pi*f2*tt1)+cos(2*pi*f3*tt1); % ����

M=50;  % ���Ƿ�����źŵĵ���

%%%%%%%% �������Ƿ����λ�� %%%%%%%%%%%%%%%%
indexM=fix(rand(1,M)*N); 
indexM=sort(indexM);
if (indexM(1)==0)
    indexM(1)=1;
end
 for kk=1:M-1
     while(indexM(kk+1)<=indexM(kk))
         indexM(kk+1)=indexM(kk+1)+1;
     end
 end
 %%%%%%%% �������Ƿ����λ�� end %%%%%%%%%%%%%%%%
 
 y2=y1(indexM); % ����Ƿ��������

DCT_Matrix=(dct(eye(N))).'; % ����ϡ��任���� ����DCT����

Sense=DCT_Matrix(indexM,:); % ���ɶ�Ӧ�Ĳ�������

%%%%%%%% OMP �㷨�ָ�
%%%%%%%% OMP start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Aug=[];
corelate=zeros(1,N);
rn=y2';
PHAI_cs=Sense;
yvec_cs=y2.';

K2=4; %�ָ�����
for kk=1:K2
    corelate=PHAI_cs'*rn;
    [va,pos]=max(abs(corelate));
    Aug=[Aug,PHAI_cs(:,pos)];
    PHAI_cs(:,pos)=zeros(M,1);
    phiy=((Aug')*Aug)^(-1)*Aug'*yvec_cs;
    rn=yvec_cs-Aug*phiy;
    posarray(kk)=pos;
    waitbar(kk/K2);
end

recover_x=zeros(N,1);
recover_x(posarray)=phiy; % �ָ���ϡ��任���ϵ��
%%%%%%%%OMP end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recover_x1=DCT_Matrix*recover_x;  % �ָ�ԭʼ�ź�

figure(1);plot((recover_x1));title('�ָ��ź�');
figure(2);plot(y1);  title('ԭʼ�ź�');
figure(3);plot(y2);  title('���Ƿ�����ź�');




