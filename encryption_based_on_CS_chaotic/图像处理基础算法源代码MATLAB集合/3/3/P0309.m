[I,map]=imread('3-22.jpg');
imshow(I,map);
I=double(I);
[Gx,Gy]=gradient(I);       % �����ݶ�
G=sqrt(Gx.*Gx+Gy.*Gy);   % ע���Ǿ�����

J1=G;
figure,imshow(J1,map);    % ��һ��ͼ����ǿ

J2=I;                   % �ڶ���ͼ����ǿ
K=find(G>=7);
J2(K)=G(K);
figure,imshow(J2,map);

J3=I;                   % ������ͼ����ǿ
K=find(G>=7);
J3(K)=255;
figure,imshow(J3,map);

J4=I;                   % ������ͼ����ǿ
K=find(G<=7);
J4(K)=255;
figure,imshow(J4,map);

J5=I;                   % ������ͼ����ǿ
K=find(G<=7);
J5(K)=0;
Q=find(G>=7);
J5(Q)=255;
figure,imshow(J5,map);
