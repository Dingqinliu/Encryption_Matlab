I=imread('eight.tif');
imshow(I) ;

J2=imnoise(I,'salt & pepper',0.04); % �����ܶ�Ϊ0.04�Ľ���������
                                           % ��ͼ3-17(c)��ʾ��
figure,imshow(J2);

I_Filter1=medfilt2(J2,[3 3]);  %���ڴ�СΪ3��3�������ͼ3-18(a)��ʾ
figure,imshow(I_Filter1);
I_Filter2=medfilt2(J2,[5 5]);  %���ڴ�СΪ5��5�������ͼ3-18(b)��ʾ
figure,imshow(I_Filter2);
I_Filter3=medfilt2(J2,[7 7]);  %���ڴ�СΪ7��7�������ͼ3-18(c)��ʾ
figure,imshow(I_Filter3);

