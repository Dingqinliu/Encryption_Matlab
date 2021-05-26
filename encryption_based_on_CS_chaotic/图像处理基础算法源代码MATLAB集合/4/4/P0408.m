I=imread('wrod213.bmp');
imshow(I);
I=~I;        % 腐蚀运算对灰度值为1的进行
figure, imshow(I);
SE=strel('square',3); % 定义3×3腐蚀结构元素
J=imerode(~I,SE);
BW=(~I)-J;        % 检测边缘
figure,imshow(BW);
