[I,map]=imread('blood1.tif');
imshow(I,map);
H2=[-1 -1 -1;-1 -9 -1;-1 -1 -1];
J1=filter2(H2,I);             % ¸ßÍ¨ÂË²¨
figure,imshow(J1,map);

I=double(I);
M=[1 1 1;1 1 1;1 1 1]/9;
J2=filter2(M,I);
J3=I-J2;                % ÑÚÄ£
figure,imshow(J3,map);
