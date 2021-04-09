function C=TpEncrypt(P,K)
[M,N]=size(P);P=double(P);n=3*M*N;s=zeros(1,n);
h=0.002;t=800;a=10;b=8/3;c=28;r=-1;x0=K(1);y0=K(2);z0=K(3);w0=K(4);%由输入密钥K得到超混沌Lorenz系统的各个状态初始值
%%迭代超混沌系统得到长度为3MN的伪随机序列
for i=1:n+t
    K11=a*(y0-x0)+w0;K12=a*(y0-(x0+K11*h/2))+w0;
    K13=a*(y0-(x0+K12*h/2))+w0;K14=a*(y0-(x0+K13*h))+w0;
    x1=x0+(K11+K12+K13+K14)*h/6;
    K21=c*x1-y0-x1*z0;K22=c*x1-(y0+K21*h/2)-x1*z0;
    K23=c*x1-(y0+K22*h/2)-x1*z0;K24=c*x1-(y0+K23*h)-x1*z0;
    y1=y0+(K21+K22+K23+K24)*h/6;
    K31=x1*y1-b*z0;K32=x1*y1-b*(z0+K31*h/2);
    K33=x1*y1-b*(z0+K32*h/2);K34=x1*y1-b*(z0+K33*h);
    z1=z0+(K31+K32+K33+K34)*h/6;
    K41=-y1*z1+r*w0;K42=-y1*z1+r*(w0+K41*h/2);
    K43=-y1*z1+r*(w0+K42*h/2);K44=-y1*z1+r*(w0+K43*h);
    w1=w0+(K41+K42+K43+K44)*h/6;
    
    x0=x1;y0=y1;z0=z1;w0=w1;
    if i>t
        s(i-t)=x1;
        if mod((i-t),3000)==0
            x0=x0+h*sin(y0);
        end
    end
end

%置乱用的伪随机序列，保存在X
X=mod(floor((s(1:M*N)+100)*10^10),M*N)+1;[~,idx]=unique(X);X1=zeros(1,M*N);%置乱用的伪随机序列
X1(1:length(idx))=X(sort(idx));X1(length(idx)+1:M*N)=setdiff(1:M*N,X1);X=X1;

%扩散用的伪随机序列 保存在S1 S2
TBL=GF257Table();S=mod(floor(s(M*N+1:3*M*N)*pow2(16)),256);
S1=S(1:M*N);S2=S(M*N+1:2*M*N);B=zeros(1,M*N);C=zeros(1,M*N);

%置乱算法 参考博客中二维图像展开成一维向量后的无重复置乱
A=P(:); 
for i=1:floor(M*N/2)
    t=A(X(i));A(X(i))=A(X(M*N-i+1));A(X(M*N-i+1))=t;
end

%扩散算法 基于GF(257)域乘法运算的扩散算法
B0=0;B(1)=LookUpGF257(B0,S1(1),A(1),TBL);
for i=2:M*N
    B(i)=LookUpGF257(B(i-1),S1(i),A(i),TBL);
end
C0=0;C(M*N)=LookUpGF257(C0,S2(M*N),B(M*N),TBL);
for i=M*N-1:-1:1
C(i)=LookUpGF257(C(i+1),S2(i),B(i),TBL);
end
C=reshape(C,M,N);C=uint8(C);
end