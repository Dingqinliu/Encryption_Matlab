[I,map]=imread('3-22.jpg');
imshow(I,map);
I=double(I);
[Gx,Gy]=gradient(I);       % 计算梯度
G=sqrt(Gx.*Gx+Gy.*Gy);   % 注意是矩阵点乘

J1=G;
figure,imshow(J1,map);    % 第一种图像增强

J2=I;                   % 第二种图像增强
K=find(G>=7);
J2(K)=G(K);
figure,imshow(J2,map);

J3=I;                   % 第三种图像增强
K=find(G>=7);
J3(K)=255;
figure,imshow(J3,map);

J4=I;                   % 第四种图像增强
K=find(G<=7);
J4(K)=255;
figure,imshow(J4,map);

J5=I;                   % 第五种图像增强
K=find(G<=7);
J5(K)=0;
Q=find(G>=7);
J5(Q)=255;
figure,imshow(J5,map);
