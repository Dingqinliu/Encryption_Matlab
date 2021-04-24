clc;clear;
u=0:0.001:1;x0=0.1;n=3000;t=1000;
len=length(u);
for i=1:len
     temp=0;
    for j=1:n
          x=g(mod(exp(-5*x0^2)-(1-u(i))+4*u(i)*x0*(1-x0),1));
          x0=x;
          if j>t
             temp=temp+log(abs(8*(4*u(i)-8*u(i)*x-10*x*exp(-5*x^2))));
             
          end
    end
    LE(i)=temp/(n-t+1);
end

figure(1);
plot(u,LE,'r');

hold on
x=get(gca,'xlim');
y=0;
plot(x,[y y],'k');
axis([0,1,-5,3]);
hold off 

set(gca,'Xtick',0:0.2:1);
set(gca,'Ytick',-5:1:3);
xlabel('u');ylabel('Lyapunov Exponent');

