
%%%%%%%%%%%%% 若干频率正弦叠加信号 随机欠采样 压缩感知恢复(OMP算法) %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% 国防科学技术大学 杨俊刚 2011.03 %%%%%%%%%%%%%%%%%%%%

clear;

Tend=6; % 信号持续时间 0-Tend
fs=200; % 原始波形采样频率
tt1=0:1/fs:Tend; % 原始波形采样时间点
N=size(tt1,2); % 采样点数 
f1=13; % 正弦信号频率
f2=5;
f3=2;
y1=cos(2*pi*f1*tt1)+cos(2*pi*f2*tt1)+cos(2*pi*f3*tt1); % 波形

M=50;  % 随机欠采样信号的点数

%%%%%%%% 生成随机欠采样位置 %%%%%%%%%%%%%%%%
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
 %%%%%%%% 生成随机欠采样位置 end %%%%%%%%%%%%%%%%
 
 y2=y1(indexM); % 生成欠采样序列

DCT_Matrix=(dct(eye(N))).'; % 生成稀疏变换矩阵 采用DCT矩阵

Sense=DCT_Matrix(indexM,:); % 生成对应的测量矩阵

%%%%%%%% OMP 算法恢复
%%%%%%%% OMP start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Aug=[];
corelate=zeros(1,N);
rn=y2';
PHAI_cs=Sense;
yvec_cs=y2.';

K2=4; %恢复点数
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
recover_x(posarray)=phiy; % 恢复的稀疏变换后的系数
%%%%%%%%OMP end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

recover_x1=DCT_Matrix*recover_x;  % 恢复原始信号

figure(1);plot((recover_x1));title('恢复信号');
figure(2);plot(y1);  title('原始信号');
figure(3);plot(y2);  title('随机欠采样信号');




