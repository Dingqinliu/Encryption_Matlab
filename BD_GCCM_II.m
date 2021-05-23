clc;clear all;close all;
% addpath(genpath('E:\matlab123\bin\Signal_processing\gx_package\g1'))
axis([0,1,0,1]);
x0=0.1;t=800;M=850;
r=0:0.002:1;
[m,n]=size(r);
tic;
hold on
for i=1:n
x(1)=g(mod(exp(-5*x0^2)-r(i)+cos((2-r(i))*acos(x0)),1));
for j =2:M
   x(j)=g(mod(exp(-5*x(j-1)^2)-r(i)+cos((2-r(i))*acos(x(j-1))),1));
end

xn{i}=x(t:M);
pause(0.1);
plot(r(i),xn{i},'r.','Markersize',2);

xlabel('r');ylabel('x');
end
toc;
