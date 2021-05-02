function y=Entropy(P)
P=double(P);[M,N]=size(P);P=transpose(P(:));T=zeros(1,256);
for i=1:256
    T(i)=sum(P==(i-1));
    T(i)=T(i)/(M*N);
end
y=-T(T>0)*transpose(log2(T(T>0)));
end