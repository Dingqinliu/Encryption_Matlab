clc;clear;
u=0:0.001:1;
n=length(u);


for i=1:n
    y(i)=log(abs(2*u(i)));
end
figure;
plot(u,y,'r.','markersize',2);
hold on
x=get(gca,'xlim');
y=0;
plot(x,[y y],'k');
axis([0,1,-5,1]);
hold off 

set(gca,'Xtick',0:0.2:1);
set(gca,'Ytick',-5:1:1);
xlabel('u');ylabel('Lyapunov Exponent');

