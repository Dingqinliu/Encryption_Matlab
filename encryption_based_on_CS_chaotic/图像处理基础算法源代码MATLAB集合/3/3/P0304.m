I=imread('pout.tif');  % ��ȡMATLAB�Դ���potu.tifͼ��
imshow(I);
figure,imhist(I);     
[J,T]=histeq(I,64);      % ͼ��Ҷ���չ��0~255������ֻ��64���Ҷȼ�
figure,imshow(J);
figure,imhist(J);
figure,plot((0:255)/255,T); % ת�ƺ����ı任����
J=histeq(I,32);
figure,imshow(J);   % ͼ��Ҷ���չ��0~255������ֻ��32���Ҷȼ�
figure,imhist(J);
