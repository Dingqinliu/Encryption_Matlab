[I,map]=imread('eight.tif');
figure,imshow(I);title('original')
J1=imnoise(I,'gaussian',0,0.02); % 受高斯噪声干扰，结果如图3-17(b)所示
[K noise]=wiener2(J1, [5 5]);
figure,imshow(K);              % 结果如图3-20所示

