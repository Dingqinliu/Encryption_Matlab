
M=4;N=4;%M��Nѡ��
rgb=imread('lena256.bmp');
[m,n,c]=size(rgb);
xb=round(m/M)*M;yb=round(n/N)*N;%�ҵ��ܱ�������M,N
rgb=imresize(rgb,[xb,yb]);
[m,n,c]=size(rgb);
count =1;
for i=1:M
    for j=1:N
        % 1�� �ֿ�
        block = rgb((i-1)*m/M+1:m/M*i,(j-1)*n/N+1:j*n/N,:); % ͼ��ֳɿ�
   %д��Ҫ��ÿһ��Ĳ���
     subplot(M,N,count);
     imshow(block)  
     count = count+1;
    end
end

