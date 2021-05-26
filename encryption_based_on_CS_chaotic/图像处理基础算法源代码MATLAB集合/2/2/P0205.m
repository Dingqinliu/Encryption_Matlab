clear;
close all;
I=imread('cameraman.tif');
imshow(I);
whos
I2=imresize(I,0.5);
figure,imshow(I2);
imwrite(I2,'cameraman.bmp');
imfinfo('cameraman.bmp')