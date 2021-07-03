function [X,Y,R,W] = PRICKeyGen(P,K)
P=double(P);
[M,N] = size(P);
x0=K(1);p=K(2);y0=K(3);q=K(4);r1=K(5);r2=K(6);r3=K(7);r4=K(8);
for i= 1:r1+r2
    x1 = PWLCM(x0,p);
    x0=x1;
end
x= zeros(1,M*N);
for i= 1:M*N
    x1 = PWLCM(x0,p);
    x(i)=x1;
    x0=x1;
end
for i= 1:r3+r4
    y1=PWLCM(y0,q);
    y0=yl;
end
y= zeros(1,M*N);
for i= 1:M*N
    y1= PWLCM(y0,q);
    y(i)=y1;
    y0=y1;
end
X=zeros(M,N);
Y=zeros(M,N);
R=zeros(M,N);
W=zeros(M,N);

a1=(r1+1)/(r1+r3+2);
b1=1-a1;
a2=(r2+1)/(r2+r4+2);
b2=1-a2;
a3=(r1+1)/(r1+r4+2);
b3=1-a3;
a4=(r2+1)/(r2+r3+2);
b4=1-a4;
for i=1:M
    for j= 1:N
        X(i,j)= mod(floor((a1*x((i-1)*N+j)+b1*y((i-1)*N+j))*power(10,14)),256);
        Y(i,j)= mod(floor((a2*x((i-1)*N+j)+b2*y((i-1)*N+j))*power(10,13)),256);
        R(i,j)= mod(floor((a3*x((i-1)*N+j)+b3*y((i-1)*N+j))*power(10,12)),N);
        W(i,j)= mod(floor((a4*x((i-1)*N+j)+b4*y((i-1)*N+j))*power(10,11)),N);
    end
end
end
