x=zeros(1);y=zeros(1);
x(1)=0.5;
y(1)=0.5;

a=0.6;
k=0.8;

for n=1:40000
	x(n+1)=sin(21./a*(y(n)+3)*k*x(n)*(1-k*x(n)));
	y(n+1)=sin(21./(a*(k*x(n+1)+3)*y(n)*(1-y(n))));

end
figure;
H=plot(x(1000:end),y(1000:end),'b');%1000
set(H,'linestyle','none','marker','.','markersize',1)
xlabel('x');ylabel('y');