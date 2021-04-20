function y=PWLCM(x,p)
if x<p
    y=x/p;
elseif x<0.5
    y=(x-p)/(0.5-p);
else
    y=PWLCM(1-x,p);
end
end
