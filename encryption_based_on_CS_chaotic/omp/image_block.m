

%  本程序实现图像LENA的压缩传感
%  程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk
%  算法采用正交匹配法，参考文献 Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit，IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  该程序没有经过任何优化

M=4;N=4;%M、N选择
rgb=imread('lena256.bmp');
[m,n,c]=size(rgb);
xb=round(m/M)*M;yb=round(n/N)*N;%找到能被整除的M,N
rgb=imresize(rgb,[xb,yb]);
[m,n,c]=size(rgb);
count =1;
for i=1:M
    for j=1:N
        % 1） 分块
        block = rgb((i-1)*m/M+1:m/M*i,(j-1)*n/N+1:j*n/N,:); % 图像分成块
   %写上要对每一块的操作
     subplot(M,N,count);
     imshow(block)  
     count = count+1;
    end
end

