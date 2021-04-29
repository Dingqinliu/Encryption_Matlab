clc;clear all;close all
axis([0,1,-0.4,1]);
x0=0.1;t=800;M=850;
r=0:0.002:1;
[m,n]=size(r);
hold on
for i=1:n
x(1)=exp(-5*x0^2)-r(i);
for j =2:M
   x(j)=exp(-5*x(j-1)^2)-r(i);
end
xn{i}=x(t:M);
pause(0.1);
plot(r(i),xn{i},'r.','Markersize',2);

xlabel('r');ylabel('x');
end