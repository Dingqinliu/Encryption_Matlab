%MATLAB图像特征提取代码

    PS=imread('D:\matlab\pic/001.jpg');
    PS=imresize(PS,[300,300],'bilinear');%归一化大小
    PS=rgb2gray(PS);
    [m,n]=size(PS);                       %测量图像尺寸参数
    GP=zeros(1,256);                     %预创建存放灰度出现概率的向量
    for k=0:255
        GP(k+1)=length(find(PS==k))/(m*n);  %计算每级灰度出现的概率，将其存入GP中相应位置
    end
%直方图均衡化
    S1=zeros(1,256);
   for i=1:256
       for j=1:i
           S1(i)=GP(j)+S1(i);              %计算Sk
       end
   end
   S2=round((S1*256)+0.5);               %将Sk归到相近级的灰度
%图像均衡化
   f=PS;
   for i=0:255
       f(find(PS==i))=S2(i+1);         %将各个像素归一化后的灰度值赋给这个像素
   end
   figure,imshow(f);
%边缘检测
   f=edge(f,'canny',0.25);
   imshow(f);
%二值法锐化图像
   f=double(f);
   [x,y]=gradient(f);
   g=sqrt(x.*x+y.*y);
   i=find(g>=0.5);
   g(i)=256;
   j=find(g<0.5);
   g(j)=0;
   imshow(g);
   title('二值法锐化图像');
%中值滤波
g=medfilt2(g); 
g=dither(g); 
imshow(g);
%提取面积，矩形度，圆形度，拉伸度特征
   [x,y]=size(g);
   BW = bwperim(g,8); %检测边缘跟踪，用于计算周长 
%检测垂直方向连读的周长像素点%
   P1=0;
   P2=0;
   Ny=0; % 记录垂直方向连续周长像素点的个数
   for i=1:x
      for j=1:y
          if (BW(i,j)>0)
              P2=j;
              if ((P2-P1)==1)% 判断是否为垂直方向连续的周长像素点
                  Ny=Ny+1;
              end
             P1=P2;
          end
      end
   end
%检测水平方向连读的周长像素点
   P1=0;
   P2=0;
   Nx=0; % 记录水平方向连续周长像素点的个数
   for j=1:y
       for i=1:x
           if (BW(i,j)>0)
               P2=i;
              if ((P2-P1)==1) % 判断是否为水平方向连续的周长像素点
                   Nx=Nx+1;
              end
              P1=P2;
           end
       end
   end 
   SN=sum(sum(BW)); % 计算周长像素点的总数
   Nd=SN-Nx-Ny; % 计算奇数码的链码数目
   H=max(sum(g)); % 计算目标的高度 
   W=max(sum(g')); % 图象g经矩阵转置后，计算宽度
   L=sqrt(2)*Nd+Nx+Ny; % 计算周长
%====形态特征值计算===%
   A=bwarea(g); % 计算目标的面积
   R=A/(H*W); % 计算矩形度
   E=min(H,W)/max(H,W); % 计算伸长度
   temp1=[A,R,E];
%提取不变矩特征
   [M,N]=size(g);
   [x,y]=meshgrid(1:N,1:M);
   x=x(:);
   y=y(:);
   g=g(:);
   m.m00=sum(g);
   if(m.m00==0)
      m.m00=eps;
   end
   m.m10=sum(x.*g);
   m.m01=sum(y.*g);
   m.m11=sum(x.*y.*g);
   m.m20=sum(x.^2.*g);
   m.m02=sum(y.^2.*g);
   m.m30=sum(x.^3.*g);
   m.m03=sum(y.^3.*g);
   m.m12=sum(x.*y.^2.*g);
   m.m21=sum(x.^2.*y.*g);
   xbar=m.m10/m.m00;
   ybar=m.m01/m.m00;
   e.eta11=(m.m11-ybar*m.m10)/m.m00^2;
   e.eta20=(m.m20-xbar*m.m10)/m.m00^2;
   e.eta02=(m.m02-ybar*m.m01)/m.m00^2;
   e.eta30=(m.m30-3*xbar*m.m20+2*xbar^2*m.m10)/m.m00^2.5;
   e.eta03=(m.m03-3*ybar*m.m02+2*ybar^2*m.m01)/m.m00^2.5;
   e.eta21=(m.m21-2*xbar*m.m11-ybar*m.m20+2*xbar^2*m.m01)/m.m00^2.5;
   e.eta12=(m.m12-2*ybar*m.m11-xbar*m.m02+2*ybar^2*m.m10)/m.m00^2.5;
   phi(1)=e.eta20+e.eta02;
   phi(2)=(e.eta20-e.eta02)^2+4*e.eta11^2;
   phi(3)=(e.eta30-3*e.eta12)^2+(3*e.eta21-e.eta03)^2;
   phi(4)=(e.eta30+e.eta12)^2+(e.eta21+e.eta03)^2;
phi(5)=(e.eta30-3*e.eta12)*(e.eta30+e.eta12)*((e.eta30+e.eta12)^2-3*(e.eta21+e.eta03)^2+(3*e.eta21-e.eta03)* (e.eta21+e.eta03)*(3*(e.eta30+e.eta12)^2-(e.eta21+e.eta03)^2));
phi(6)=(e.eta20-e.eta02)*((e.eta30+e.eta12)^2-(e.eta21+e.eta03)^2)+4*e.eta11*(e.eta30+e.eta12)*(e.eta21+e.eta03);
phi(7)=(3*e.eta21-e.eta03)*(e.eta30+e.eta12)*((e.eta30+e.eta12)^2-3*(e.eta21+e.eta03)^2)+(3*e.eta12-e.eta30)* (e.eta21+e.eta03)*(3*(e.eta30+e.eta12)^2-(e.eta21+e.eta03)^2); 
   temp2 = abs(log(phi));%包含七个特征值
   temp=[temp1,temp2]