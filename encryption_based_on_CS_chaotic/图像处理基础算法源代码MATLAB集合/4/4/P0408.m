I=imread('wrod213.bmp');
imshow(I);
I=~I;        % ��ʴ����ԻҶ�ֵΪ1�Ľ���
figure, imshow(I);
SE=strel('square',3); % ����3��3��ʴ�ṹԪ��
J=imerode(~I,SE);
BW=(~I)-J;        % ����Ե
figure,imshow(BW);
