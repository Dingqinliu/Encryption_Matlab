I = imread('bacteria.BMP');
BW1 = edge(I,'log',0.003);  % ��=2
imshow(BW1);title('��=2')
BW1 = edge(I,'log',0.003,3); % ��=3
figure, imshow(BW1);title('��=3')
