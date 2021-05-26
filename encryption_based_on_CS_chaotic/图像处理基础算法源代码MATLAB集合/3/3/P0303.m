I=imread('rice.tif');
imshow(I);
figure,imhist(I);
J=imadjust(I,[0.15 0.9], [0 1]);
figure,imshow(J);
figure,imhist(J);
