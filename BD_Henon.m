clc;clear all;close all
x0=0.1;y0=0.2;b=1;n=850;t=800;

hold on
for a = 0:0.002:1
x(1)=1+y0-a*x0^2;
y(1)=b*x0;
for i =2:n
   x(i)=1+y(i-1)-7/5*a*x(i-1)^2;
   y(i)=3/10*b*x(i-1);
end
xn=x(t+1:n);
pause(0.1);
plot(a,xn,'r.','Markersize',2);
xlabel('a');ylabel('x');
set(gca,'XLim',[0 1]);
set(gca,'XTick',[0:0.2:1]);
set(gca,'YLim',[-1.5  1.5]);
set(gca,'YTick',[-1.5:0.5:1.5]);
end