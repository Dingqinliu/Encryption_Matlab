clc;clear all;close all
axis([0.1,0.5,0,1]);
x0=0.1;t=800;M=850;
r=0.1:0.001:0.49;
[m,n]=size(r);
hold on
for i=1:n
   x(1)=pwlcm(r(i),x0);
for j =2:M
     x(j)=pwlcm(r(i),x(j-1));
end
xn=x(t:M);
pause(0.1);
plot(r(i),xn,'r.','Markersize',2);

xlabel('r');ylabel('x(i)');
end