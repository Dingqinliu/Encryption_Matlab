clc;clear all;close all
axis([0,1,-1,1]);
x0=0.1;t=800;M=850;
r=0:0.002:1;
[m,n]=size(r);
tic;
hold on
for i=1:n
x(1)=cos((r(i)+1)*acos(x0));
for j =2:M
   x(j)=cos((r(i)+1)*acos(x(j-1)));
end
xn{i}=x(t:M);
pause(0.1);
plot(r(i),xn{i},'r.','Markersize',2);

xlabel('r');ylabel('x(i)');
end
toc;