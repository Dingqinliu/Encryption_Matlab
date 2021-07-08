%MATLABͼ��������ȡ����

    PS=imread('D:\matlab\pic/001.jpg');
    PS=imresize(PS,[300,300],'bilinear');%��һ����С
    PS=rgb2gray(PS);
    [m,n]=size(PS);                       %����ͼ��ߴ����
    GP=zeros(1,256);                     %Ԥ������ŻҶȳ��ָ��ʵ�����
    for k=0:255
        GP(k+1)=length(find(PS==k))/(m*n);  %����ÿ���Ҷȳ��ֵĸ��ʣ��������GP����Ӧλ��
    end
%ֱ��ͼ���⻯
    S1=zeros(1,256);
   for i=1:256
       for j=1:i
           S1(i)=GP(j)+S1(i);              %����Sk
       end
   end
   S2=round((S1*256)+0.5);               %��Sk�鵽������ĻҶ�
%ͼ����⻯
   f=PS;
   for i=0:255
       f(find(PS==i))=S2(i+1);         %���������ع�һ����ĻҶ�ֵ�����������
   end
   figure,imshow(f);
%��Ե���
   f=edge(f,'canny',0.25);
   imshow(f);
%��ֵ����ͼ��
   f=double(f);
   [x,y]=gradient(f);
   g=sqrt(x.*x+y.*y);
   i=find(g>=0.5);
   g(i)=256;
   j=find(g<0.5);
   g(j)=0;
   imshow(g);
   title('��ֵ����ͼ��');
%��ֵ�˲�
g=medfilt2(g); 
g=dither(g); 
imshow(g);
%��ȡ��������ζȣ�Բ�ζȣ����������
   [x,y]=size(g);
   BW = bwperim(g,8); %����Ե���٣����ڼ����ܳ� 
%��ⴹֱ�����������ܳ����ص�%
   P1=0;
   P2=0;
   Ny=0; % ��¼��ֱ���������ܳ����ص�ĸ���
   for i=1:x
      for j=1:y
          if (BW(i,j)>0)
              P2=j;
              if ((P2-P1)==1)% �ж��Ƿ�Ϊ��ֱ�����������ܳ����ص�
                  Ny=Ny+1;
              end
             P1=P2;
          end
      end
   end
%���ˮƽ�����������ܳ����ص�
   P1=0;
   P2=0;
   Nx=0; % ��¼ˮƽ���������ܳ����ص�ĸ���
   for j=1:y
       for i=1:x
           if (BW(i,j)>0)
               P2=i;
              if ((P2-P1)==1) % �ж��Ƿ�Ϊˮƽ�����������ܳ����ص�
                   Nx=Nx+1;
              end
              P1=P2;
           end
       end
   end 
   SN=sum(sum(BW)); % �����ܳ����ص������
   Nd=SN-Nx-Ny; % �����������������Ŀ
   H=max(sum(g)); % ����Ŀ��ĸ߶� 
   W=max(sum(g')); % ͼ��g������ת�ú󣬼�����
   L=sqrt(2)*Nd+Nx+Ny; % �����ܳ�
%====��̬����ֵ����===%
   A=bwarea(g); % ����Ŀ������
   R=A/(H*W); % ������ζ�
   E=min(H,W)/max(H,W); % �����쳤��
   temp1=[A,R,E];
%��ȡ���������
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
   temp2 = abs(log(phi));%�����߸�����ֵ
   temp=[temp1,temp2]