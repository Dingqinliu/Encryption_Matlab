clear;
clf;

%%����X1��R��X
t=-2*pi:0.05:2*pi;      % t��ȡֵ��-2*pi��2*pi,���Ϊ0.05
X1=1.5*(cos(t*pi)+2*sin(2*pi*t)+0.5*cos(pi*t)+exp(0.3*t));   %ԭ�ź�X1
figure(1);
plot(t,X1);title('ԭʱ������X1�ĺ���ͼ��');xlabel('t');ylabel('X1');   %��X1��ͼ
X1_size=size(X1)      %��ΪX=X1+Rʱ��Ҫ��X1��R��ά����ͬ ���������Ǽ�����һ��X1��ά�� ������1*252
n=length(X1);         %��ΪX1_size��1*252����������ֱ����ó���252����
R=random('Poisson',1,1,n);   %��������1�Ĳ��ɷֲ� ��һ��1�ǲ�����������������ʾR��ά����1*n ��X1��ά����ͬ
X=X1+R;
figure(2);
plot(t,X);title('��������X�ĺ���ͼ��');xlabel('t');ylabel('X'); %��X��ͼ ע�������Ա�����Ȼ��t

%%ʹ��ָ���ƶ�ƽ��ƽ��Ԥ�����㷨
%��������Ϊx�����Ϊy����ƽ����ʽΪ �� ��ʾȨ��ϵ������ʼ�� 
a=0.4;
Y=zeros(1,n);
Y(1)=X(1);
for i=2:n
    Y(i)=a*X(i)+(1-a)*Y(i-1);
end
figure(3);
plot(t,Y);title('ƽ��Ԥ�����Y�ĺ���ͼ��');xlabel('t');ylabel('Y');

%%����Y��X1��ƽ���ٷֱ����
MAPE=(1/n)*abs(sum(sum((Y-X)./X)))

%% ͼ1 X1��X�ĶԱ�ͼ
% ����ɫʵ�ߣ� X��Ʒ��ɫʵ�ߣ����α�ǣ�
%��Ǵ�СΪ4�����α�ԵƷ��ɫ������ɫ��
%�߿�1.5�����������������ͼ���������ָ��ߣ���
figure(4);
plot(t,X1,'-bs','LineWidth',1.5,'MarkerEdgeColor','m','MarkerFaceColor','y','MarkerSize',4);% 'y'������ʾ��ɫ���� ��֪��Ϊ���ҵĵ��Ծ�����Ч
xlabel('t');
hold on;
plot(t,X,'-ms','LineWidth',1.5,'MarkerEdgeColor','m','MarkerFaceColor','y','MarkerSize',4);
legend('ԭʱ������X1�ĺ���ͼ��','��������X�ĺ���ͼ��');
title('ʱ������X1����������X�ĶԱ�����ͼ');
grid on

%% ͼ2 
%ͼ2����ʱ������X1��ƽ������Y�ĶԱ�����ͼ��X1����ɫʵ�ߣ�Y�ú�ɫʵ�ߣ�����Ǳ�ǣ�
%��Ǵ�СΪ4������Ǳ�Ե��ɫ���߿�1.5�����������������ͼ���������ָ��ߣ���
figure(5);
plot(t,X1,'-bp','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',4);
xlabel('t');
hold on;
plot(t,Y,'-rp','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',4);%��ԵΪ��ɫ��������̫��
legend('ԭʱ������X1�ĺ���ͼ��','ƽ������Y�ĺ���ͼ��');
title('ʱ������X1��ƽ������Y�ĶԱ�����ͼ');
grid on
