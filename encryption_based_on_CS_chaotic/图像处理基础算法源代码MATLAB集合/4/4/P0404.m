I=imread('blood1.tif');
imhist(I);          % �۲�Ҷ�ֱ��ͼ�� �Ҷ�140���йȣ�ȷ����ֵT=140
I1=im2bw(I,140/255); % im2bw������Ҫ���Ҷ�ֵת����[0,1]��Χ��
figure,imshow(I1);
