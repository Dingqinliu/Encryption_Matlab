I = imread('bacteria.BMP');
BW1 = edge(I,'prewitt',0.04);             %  0.04ÎªÌİ¶ÈãĞÖµ
figure(1);
imshow(I);
figure(2);
imshow(BW1);
