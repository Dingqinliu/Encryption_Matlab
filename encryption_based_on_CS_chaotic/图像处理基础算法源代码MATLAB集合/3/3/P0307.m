[I,map]=imread('eight.tif');
figure,imshow(I);title('original')
J1=imnoise(I,'gaussian',0,0.02); % �ܸ�˹�������ţ������ͼ3-17(b)��ʾ
M4=[0 1 0; 1 0 1; 0 1 0];
M4=M4/4;                 % 4����ƽ���˲�
I_filter1=filter2(M4,J1);
figure,imshow(I_filter1,map);  % �����ͼ3-19(a)��ʾ

M8=[1 1 1; 1 0 1; 1 1 1];      % 8����ƽ���˲�
M8=M8/8;
I_filter2=filter2(M8,J1);
figure,imshow(I_filter2,map);  % �����ͼ3-19(b)��ʾ


