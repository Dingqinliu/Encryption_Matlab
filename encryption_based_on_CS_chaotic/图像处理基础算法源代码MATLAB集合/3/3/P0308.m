[I,map]=imread('eight.tif');
figure,imshow(I);title('original')
J1=imnoise(I,'gaussian',0,0.02); % �ܸ�˹�������ţ������ͼ3-17(b)��ʾ
[K noise]=wiener2(J1, [5 5]);
figure,imshow(K);              % �����ͼ3-20��ʾ

