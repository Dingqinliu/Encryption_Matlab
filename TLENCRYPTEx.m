function C=TLENCRYPTEx(P,K,mtd1,mtd2)
P1=double(P);[M,N]=size(P1);m=M*N;x1=K(1);p1=K(2);x2=K(3);p2=K(4);x3=K(5);
SA=zeros(1,m);SB=zeros(1,m);SC=zeros(1,m);
xx0=x1;pp1=0.25+0.5*p1;            %Tent映射
for i=1:200+m                              
    if xx0<pp1
        xx1=xx0/pp1;
    else
        xx1=(1-xx0)/(1-pp1);             
    end
    if i>200
        SA(i-200)=xx1;
    end
    xx0=xx1;
    if mod(i,2000)==0
        xx0=xx0+(10^(-10))*sin(xx0);
    end
end

xx0=x2;pp1=0.5*p2;                %分段线性映射
for i=1:200+m
    xx1=PWLCM(xx0,pp1);
    if i>200
        SB(i-200)=xx1;
    end
    xx0=xx1;
    if mod(i,2000)==0
        xx0=xx0+(10^(-10))*sin(xx0);
    end
end

xx0=x3;                        %Logistic映射
for i=1:200+m
    xx1=4.0*xx0*(1-xx0);
    if i>200
        SC(i-200)=xx1;
    end
    xx0=xx1;
    if mod(i,2000)==0
        xx0=xx0+(10^(-10))*sin(xx0);
    end
end

if m>400                          
    u=16;
else
    u=4;
end

SAx=SA(1:u);SBy=SB(1:u);                                   %步骤3
Sx=mod(floor((SAx*100-floor(SAx*100))*(10^6)),M);
Sy=mod(floor((SBy*100-floor(SBy*100))*(10^6)),N);
I=transpose(P1(:));
v=zeros(1,u);isel=N*Sx+Sy;isel=unique(isel,'stable');isel=isel(1:u);
for i=1:u
    v(i)=I(isel(i));
end
if u==16
    V=[v(1:4);v(5:8);v(9:12);v(13:16)];E=[1;1;1;1];
    vr=transpose(V*E+E);vc=transpose(E)*V+transpose(E);
else
    vr=v+1;vc=v+1;
end

SCz=SC(1:u);Sz=mod(floor((SCz*100-floor(SCz*100))*(10^6)),256);   %步骤4
vv=zeros(1,u);vv(1)=mod(v(u)+Sz(1),256);
for i=2:u
    vv(i)=mod(vv(i-1)+v(u+1-i)+Sz(i),256);
end
C1=zeros(1,m);                         
for i=1:u
    C1(isel(i))=vv(i);           %前u个元素加密 
end

xD=mod(SA(u+1:end)+SC(u+1:end),1);pD=mod(SB(u+1:end)+SC(u+1:end),1);%步骤5
xE=zeros(1,m-u);pE=zeros(1,m-u);
for i=1:m-u
    xE(i)=mod(vr*transpose(SC(u+i-3:u+i)),1);
    pE(i)=mod(vc*transpose(SC(u+i-3:u+i)),1);
end
xF=mod(xD+xE,1);pF=mod(pD+pE,1);

xG=zeros(1,m-u);               %步骤6
for i=1:m-u                          
    xG(i)=PWLCM(xF(i),pF(i)/2);
end
xH=mod(floor((xG*100-floor(xG*100))*(10^6)),256);

J=I;idx=zeros(1,u);    %步骤7
for i=1:u
    idx(i)=(isel(i));
end
idx=sort(idx);J(idx)=[];
switch mtd1                    %4种算法
    case 1
        Ct=bitxor(J,xH);
    case 2
        Ct=mod(J+xH,256);
    case 3
        Ct=zeros(1,m-u);Ct(1)=mod(J(1)+xH(1),256);
        for i=2:m-u
            Ct(i)=mod(J(i)+xH(i)+Ct(i-1),256);
        end
    case 4
        Cf=zeros(1,m-u);Cf(1)=mod(J(1)+xH(1),256);
        for i=2:m-u
            Cf(i)=mod(J(i)+xH(i)+Cf(i-1),256);
        end
        Ct=zeros(1,m-u);xI=mod(floor((xG*100-floor(xG*100))*(10^7)),256);
        Ct(m-u)=mod(Cf(m-u)+xI(m-u),256);
        for i=m-u-1:-1:1
            Ct(i)=mod(Cf(i)+xI(i)+Ct(i+1),256);
        end
end

C1(1:idx(1)-1)=Ct(1:idx(1)-1);
for i=2:u
    C1(idx(i-1)+1:idx(i)-1)=Ct(idx(i-1)-i+2:idx(i-1)-i+1+(idx(i)-idx(i-1)-1));
end
C1(idx(u)+1:end)=Ct(idx(u)-u+1:end);C2=C1;

RAx=SA(m-u+1:end);RBy=SB(m-u+1:end);                       %步骤8-1        
Rx=mod(floor((RAx*100-floor(RAx*100))*(10^6)),M);
Ry=mod(floor((RBy*100-floor(RBy*100))*(10^6)),N);
w=zeros(1,u);isel=M*Rx+Ry;isel=unique(isel,'stable');isel=isel(end-u+1:end);
for i=1:u
    w(i)=C2(isel(i));
end
if u==16
    W=[w(1:4);w(5:8);w(9:12);w(13:16)];E=[1;1;1;1];
    wr=transpose(W*E+E);wc=transpose(E)*W+transpose(E);
else
    wr=w+1;wc=w+1;
end

RCz=SC(m-u+1:end);Rz=mod(floor((RCz*100-floor(RCz*100))*(10^6)),256);   %步骤8-2
ww=zeros(1,u);ww(1)=mod(w(1)+Rz(u),256);
for i=2:u
    ww(i)=mod(ww(i-1)+w(i)+Rz(u+1-i),256);
end
C3=zeros(1,m);                         
for i=1:u
    C3(isel(i))=ww(i);            
end

yD=mod(SA(1:m-u)+SC(1:m-u),1);qD=mod(SB(1:m-u)+SC(1:m-u),1);%步骤8-3
yE=zeros(1,m-u);qE=zeros(1,m-u);
for i=1:m-u
    yE(i)=mod(wr*transpose(SC(m-u-i+1:m-u-i+4)),1);
    qE(i)=mod(wc*transpose(SC(m-u-i+1:m-u-i+4)),1);
end
yF=mod(yD+yE,1);qF=mod(qD+qE,1);yG=zeros(1,m-u);

for i=1:m-u                          %步骤8-4
    yG(i)=PWLCM(yF(i),qF(i)/2);
end
yH=mod(floor((yG*100-floor(yG*100))*(10^6)),256);

J=C2;idx=zeros(1,u);    
for i=1:u
    idx(i)=(isel(i));
end
idx=sort(idx);J(idx)=[];
switch mtd2                    %4种算法
    case 1
        yH=fliplr(yH);Ct=bitxor(J,yH);
    case 2
        yH=fliplr(yH);Ct=mod(J+yH,256);
    case 3
        Ct=zeros(1,m-u);Ct(m-u)=mod(J(m-u)+yH(m-u),256);
        for i=m-u-1:-1:1
            Ct(i)=mod(J(i)+yH(i)+Ct(i+1),256);
        end
    case 4
        CB=zeros(1,m-u);CB(m-u)=mod(J(m-u)+yH(m-u),256);
        for i=m-u-1:-1:1
            CB(i)=mod(J(i)+yH(i)+CB(i+1),256);
        end
        Ct=zeros(1,m-u);yI=mod(floor((yG*100-floor(yG*100))*(10^7)),256);
        Ct(1)=mod(CB(1)+yI(1),256);
        for i=2:m-u
            Ct(i)=mod(CB(i)+yI(i)+Ct(i-1),256);
        end
end

C3(1:idx(1)-1)=Ct(1:idx(1)-1);
for i=2:u
    C3(idx(i-1)+1:idx(i)-1)=Ct(idx(i-1)-i+2:idx(i-1)-i+1+(idx(i)-idx(i-1)-1));
end
C3(idx(u)+1:end)=Ct(idx(u)-u+1:end);C3=reshape(C3,M,N);C=C3;
end





