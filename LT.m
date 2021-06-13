%clc;clear all;
function  s=LT(r,x0,n)
s=zeros(1,n); 
 for i=1:n+800;
     if x0<0.5
        x1=mod(r*x0*(1-x0)+(4-r)*x0/2,1);
     else 
        x1=mod(r*x0*(1-x0)+(4-r)*(1-x0)/2,1);
     end
     if i>800
        s(i-800)=x1;
     end
     x0=x1;
     if mod(i,2000)==0
        x0=x0+(10^(-10))*sin(x0);
     end
 end
end