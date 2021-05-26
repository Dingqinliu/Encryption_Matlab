I=imread('circbw.tif');
imshow(I);
SE=strel('rectangle',[40 30]);  % 结构定义
J=imopen(I,SE);            % 开启运算
figure,imshow(J);
