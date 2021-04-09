function P=TpDecrypt(C,K)
[M,N]=size(C);C=double(C);n=3*M*N;s=zeros(1,n);
h=0.002;t=800;a=10;b=8/3;c=28;r=-1;x0=K(1);y0=K(2);z0=K(3);w0=K(4);
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

X=mod(floor((s(1:M*N)+100)*10^10),M*N)+1;[~,idx]=unique(X);X1=zeros(1,M*N);
X1(1:length(idx))=X(sort(idx));X1(length(idx)+1:M*N)=setdiff(1:M*N,X1);X=X1;

TBL=GF257Table();S=mod(floor(s(M*N+1:3*M*N)*pow2(16)),256);
S1=S(1:M*N);S2=S(M*N+1:2*M*N);
A=C(:);D=zeros(1,M*N);E=zeros(1,M*N);
A0=0;D(M*N)=LookUpGF257Ex(A(M*N),A0,S2(M*N),TBL);
for i=M*N-1:-1:1
   D(i)=LookUpGF257Ex(A(i),A(i+1),S2(i),TBL); 
end
E0=0;E(1)=LookUpGF257Ex(D(1),E0,S1(1),TBL);
for i=2:M*N
    E(i)=LookUpGF257Ex(D(i),D(i-1),S1(i),TBL);
end
for i=1:floor(M*N/2)
  t=E(X(i));E(X(i))=E(X(M*N-i+1));E(X(M*N-i+1))=t;  
end
P=reshape(E,M,N);P=uint8(P);
end




