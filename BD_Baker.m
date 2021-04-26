clc;clear all;close all
axis([0,1,0,10]);
x0=0.1;y0=0.2;t=800;M=850;
r=0.002:0.005:1;
[m,n]=size(r);
hold on
for i=1:n
    if x0<=r(i)
        x(1)=x0/r(i);
        y(1)=y0*r(i);
    end
    
    if x0>r(i)
        x(1)=(x0-r(i))*(1-r(i))^(-1);
        y(1)=(1-r(i))*(y0+1);
    end
for j =2:M
     if x(j-1)<=r(i)
        x(j)=x(j-1)/r(i);
        y(j)=y(j-1)*r(i);
    end
    
    if x(j-1)>r(i)
        x(j)=(x(j-1)-r(i))*(1-r(i))^(-1);
        y(j)=(1-r(i))*(y(j-1)+1);
    end
end
xn{i}=x(t+1:M);
yn{i}=y(t+1:M);
pause(0.1);
figure(1);
plot(r(i),yn{i},'r.','Markersize',2);

xlabel('r');ylabel('x(i)');
end