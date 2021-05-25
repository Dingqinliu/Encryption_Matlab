clear all;clc;
u=0:0.001:1;p=100;k=length(u);
for n=1:k 
    for m=2:p
        x(1,n)=0.1;
          x(m,n)=u(n)*sin(pi*x(m-1,n));
    end
end

for r=1:k 
   for h=2:p 
       A{1,r}=[pi*u(r)*cos(pi*x(1,r))];
       A{h,r}=[pi*u(r)*cos(pi*x(h,r))]*A{h-1,r}; 
   end
end

for t=1:k  
    vv(:,t)=eig(A{p,t});
     v=abs(vv);
    LE1=1/p*log(v);
end
plot(u,LE1,'b');