clc;clear;
p1=0:0.0001:0.5;
p2=0.5:0.0001:1;
p=0:0.0001:1;

for i=1:length(p1)
    y1(i)=log(abs(1/p1(i)));
end

for i=1:length(p2)
    y2(i)=log(abs(1/(1-p2(i))));
end
y=[y1 y2(2:end)];
plot(p,y,'r.','markersize',2);
xlabel('u');ylabel('Lyapunov Exponent');

