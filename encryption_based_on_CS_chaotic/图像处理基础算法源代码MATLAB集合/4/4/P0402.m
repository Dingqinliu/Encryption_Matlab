I = imread('bacteria.BMP');
BW1 = edge(I,'log',0.003);  % 考=2
imshow(BW1);title('考=2')
BW1 = edge(I,'log',0.003,3); % 考=3
figure, imshow(BW1);title('考=3')
