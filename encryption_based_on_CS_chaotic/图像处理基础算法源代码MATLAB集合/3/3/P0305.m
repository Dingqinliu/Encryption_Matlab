I=imread('eight.tif');
imshow(I) ;

J1=imnoise(I,'gaussian',0,0.02); % ���Ӿ�ֵΪ0������Ϊ0.02�ĸ�˹������������
                                       % localvar���棬��ͼ3-17(b)��ʾ
figure,imshow  (J1);

J2=imnoise(I,'salt & pepper',0.04); % �����ܶ�Ϊ0.04�Ľ���������
                                           % ��ͼ3-17(c)��ʾ��
figure,imshow(J2);


