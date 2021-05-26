I=imread('eight.tif');
imshow(I) ;

J1=imnoise(I,'gaussian',0,0.02); % 叠加均值为0，方差为0.02的高斯噪声，可以用
                                       % localvar代替，如图3-17(b)所示
figure,imshow  (J1);

J2=imnoise(I,'salt & pepper',0.04); % 叠加密度为0.04的椒盐噪声。
                                           % 如图3-17(c)所示。
figure,imshow(J2);


