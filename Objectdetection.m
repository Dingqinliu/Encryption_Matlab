clear;
clc;
fileName = 'Traffic_1000.avi'; 
obj = VideoReader(fileName);
obj_numberofframe = obj.NumberOfFrame;%��ȡ�ܵ�֡��

numFrames = obj.CurrentTime;% ֡������
for k = 1 : numFrames% ��ȡ����
     frame = readframe(obj,k);
     imshow(frame);%��ʾ֡
     imwrite(frame,strcat(num2str(k),'.jpg'),'jpg');% ����֡
end

i1=imread('1.jpg');
i2=imread('4.jpg');
i1=rgb2gray(i1);
i2=rgb2gray(i2);
[m,n]=size(i1);
im1=double(i1);
im2=double(i2);

T = 70;
i3=zeros(size(i1));
for i=1:m;
    for j=1:n;
        if abs((im2(i,j))-(im1(i,j)))>T  ; %�����ֵ��70��90֮��
              i3(i,j)=1;
        else abs((im2(i,j))-(im1(i,j)))<T;
              i3(i,j)=0;
        end
    end;
end;
 
%i3  = abs(im2-im1)>T; 
imshow(i3);
SE = ones(5,5);
i3= bwmorph(i3,'dilate',9);
i3 = imerode(i3, SE);
[L, nm] = bwlabel(i3,8); %�ҳ�8��ͨ�򲢱��
for i = 1:nm
    [r,c] = find(L == i);
    left = min(c);
    right = max(c);
    top = min(r);
    buttom = max(r);
    width = right - left + 1;
    height = buttom -top + 1;
    rectangle('Position', [left, top, width, height],'EdgeColor',[1,0,0]);
end