function R =DMMCP(r,x0,x1,x2,x3,M,N) %传入 图X 初始参数 需要加一个x3 压缩率

%这里是用了一个logistic-tent映射生成混沌序列 具体看我之前的上传
X1=LT(r,x0,n);
Y1=LT(r,x1,n);
Z1=LT(r,x2,n);
W1=LT(r,x3,n);

fai=floor((X1+Y1+Z1+W1)/4);
R=reshape(fai,M,N);
end
