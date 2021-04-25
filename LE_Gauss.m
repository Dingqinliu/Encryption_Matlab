clc;clear;
u=0:0.0001:1.3;x0=0.1;n=3000;t=1000;
len=length(u);
for i=1:len
     temp=0;
    for j=1:n
          x=exp(-5*x0^2)-u(i);
          x0=x;
          if j>t
             temp=temp+log(abs(-10*x*exp(-5*x^2)));
          end
    end
    LE(i)=temp/(n-t+1);
end

figure(1);
plot(u,LE,'r.','markersize',2);

hold on
x=get(gca,'xlim');
y=0;
plot(x,[y y],'k');
axis([0,1,-5,1]);
hold off 

set(gca,'Xtick',0:0.2:1);
set(gca,'Ytick',-5:1:1);
xlabel('u');ylabel('Lyapunov Exponent');

