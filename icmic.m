clear;
clf;
u=3.0:0.001:6.0;
x=1;
for i=1:300
x=sin(u./x);
end
for j=1:80
x=sin(u./x);
plot(u,x,'k.','markersize',2)
hold on;
end