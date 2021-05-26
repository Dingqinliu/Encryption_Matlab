I=imread('testpat1.tif');
imshow(I);
J=filter2([1 2; -1 -2], I);
figure,imshow(J,[]);
