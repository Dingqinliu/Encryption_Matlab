I=imread('circbw.tif');
imshow(I);
SE=strel('rectangle',[40 30]);  % �ṹ����
J=imopen(I,SE);            % ��������
figure,imshow(J);
