%clc;clear all;
function [r,x0,x1,x2]=SHA256(X)
%X=imread('lena256.bmp');
X=(uint8(X));
h=hash(X,'SHA256');
for j=1:32
        a{j}=h(2*j-1:2*j);
end
for i=1:32
        b(i)=hex2dec(a{i})'; 
end
x0=bitxor(bitxor(b(3),b(9)),b(27));
x0=x0/256;
x1=bitxor(bitxor(bitxor(bitxor(b(1),b(8)),b(16)),b(24)),b(32)); 
x1=x1/256;
x2=bitxor(bitxor(bitxor(bitxor(b(5),b(10)),b(15)),b(20)),b(25));
x2=x2/256;
r=bitxor(bitxor(b(2),b(7)),b(14));
r=r/256;
end
