r=1;
i=2;
for i=2:1000
    if (r<1000)
        r=r*i;
    else
        break;
    end    
end    
Answer_r=r