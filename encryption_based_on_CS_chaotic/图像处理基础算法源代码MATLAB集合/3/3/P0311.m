I=imread('Saturn.tif');
imshow(I);
J1=imnoise(I,'salt & pepper');   % ���ӽ�������
figure,imshow(J1);
f=double(J1);     % ��������ת����MATLAB��֧��ͼ����޷������͵ļ���
g=fft2(f);        % ����Ҷ�任
g=fftshift(g);     % ת�����ݾ���
[M,N]=size(g);
nn=2;           % ���װ�����˹(Butterworth)��ͨ�˲���
d0=50;
m=fix(M/2); n=fix(N/2);
for i=1:M
       for j=1:N
           d=sqrt((i-m)^2+(j-n)^2);
           h=1/(1+0.414*(d/d0)^(2*nn));  % �����ͨ�˲������ݺ���
           result(i,j)=h*g(i,j);
       end
end
result=ifftshift(result);
J2=ifft2(result);
J3=uint8(real(J2));
figure,imshow(J3);                      % ��ʾ�˲�������ͼ��
