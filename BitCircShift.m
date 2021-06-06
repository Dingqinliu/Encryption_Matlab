function y=BitCircShift(x,k);
if abs(k)>7||k==0
    y=x;return;
    
end
if k>0
    t1=mod(x*pow2(k),256);t2=floor(x/pow2(8-k));t2=floor(x/pow2(8-k));
else
    t1=floor(x*pow2(k));t2=mod(x,pow2(-k))*pow2(8+k);
end
y=t1+t2;
end

