I = imread('bacteria.BMP');
imshow(I);
BW1 = edge(I,'canny',0.2);  
figure,imshow(BW1);
