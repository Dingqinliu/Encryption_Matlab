[I,map]=imread('eight.tif');
figure,imshow(I);title('original')
J1=imnoise(I,'gaussian',0,0.02); % 受高斯噪声干扰，结果如图3-17(b)所示
M4=[0 1 0; 1 0 1; 0 1 0];
M4=M4/4;                 % 4邻域平均滤波
I_filter1=filter2(M4,J1);
figure,imshow(I_filter1,map);  % 结果如图3-19(a)所示

M8=[1 1 1; 1 0 1; 1 1 1];      % 8邻域平均滤波
M8=M8/8;
I_filter2=filter2(M8,J1);
figure,imshow(I_filter2,map);  % 结果如图3-19(b)所示


