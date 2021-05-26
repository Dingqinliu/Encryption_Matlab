I=imread('4-11.jpg');
I1=I(:,:,1);
I2=I(:,:,2);
I3=I(:,:,3);
[y,x,z]=size(I);

d1=zeros(y,x);
d2=d1;
myI=double(I);
I0=zeros(y,x);
for i=1:x
    for j=1:y
%欧式聚类
d1(j,i)=sqrt((myI(j,i,1)-180)^2+(myI(j,i,2)-180)^2+(myI(j,i,3)-180)^2); 
d2(j,i)=sqrt((myI(j,i,1)-200)^2+(myI(j,i,2)-200)^2+(myI(j,i,3)-200)^2);
        
        if (d1(j,i)>=d2(j,i))
             I0(j,i)=1;
        end 
    end 
end

figure(1);
imshow(I);
% 显示RGB空间的灰度直方图，确定两个聚类中心(180,180,180)和(200,200,200)
figure(2);     
subplot(1,3,1); 
imhist(I1);
subplot(1,3,2);
imhist(I2);
subplot(1,3,3);
imhist(I3);

figure(4);
imshow(I0);
