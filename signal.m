clear;
clf;

%%产生X1，R，X
t=-2*pi:0.05:2*pi;      % t的取值从-2*pi到2*pi,间隔为0.05
X1=1.5*(cos(t*pi)+2*sin(2*pi*t)+0.5*cos(pi*t)+exp(0.3*t));   %原信号X1
figure(1);
plot(t,X1);title('原时间序列X1的函数图像');xlabel('t');ylabel('X1');   %画X1的图
X1_size=size(X1)      %因为X=X1+R时，要求X1和R的维度相同 所以这里是计算了一下X1的维度 发现是1*252
n=length(X1);         %因为X1_size是1*252，所以这里直接求得长度252就行
R=random('Poisson',1,1,n);   %参数服从1的泊松分布 第一个1是参数，后两个参数表示R的维度是1*n 和X1的维度相同
X=X1+R;
figure(2);
plot(t,X);title('加噪声后X的函数图像');xlabel('t');ylabel('X'); %画X的图 注意这里自变量仍然是t

%%使用指数移动平均平滑预处理算法
%假设输入为x，输出为y，则平滑公式为 ， 表示权重系数。初始化 
a=0.4;
Y=zeros(1,n);
Y(1)=X(1);
for i=2:n
    Y(i)=a*X(i)+(1-a)*Y(i-1);
end
figure(3);
plot(t,Y);title('平滑预处理后Y的函数图像');xlabel('t');ylabel('Y');

%%计算Y与X1的平均百分比误差
MAPE=(1/n)*abs(sum(sum((Y-X)./X)))

%% 图1 X1与X的对比图
% 用蓝色实线； X用品红色实线，方形标记，
%标记大小为4，方形边缘品红色，填充黄色；
%线宽1.5磅；添加坐标轴名，图名；画出分格线）。
figure(4);
plot(t,X1,'-bs','LineWidth',1.5,'MarkerEdgeColor','m','MarkerFaceColor','y','MarkerSize',4);% 'y'本来表示黄色填充的 不知道为何我的电脑就是无效
xlabel('t');
hold on;
plot(t,X,'-ms','LineWidth',1.5,'MarkerEdgeColor','m','MarkerFaceColor','y','MarkerSize',4);
legend('原时间序列X1的函数图像','加噪声后X的函数图像');
title('时间序列X1与噪声序列X的对比曲线图');
grid on

%% 图2 
%图2画出时间序列X1与平滑序列Y的对比曲线图。X1用蓝色实线；Y用红色实线，五角星标记，
%标记大小为4，五角星边缘红色，线宽1.5磅；添加坐标轴名，图名；画出分格线）。
figure(5);
plot(t,X1,'-bp','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',4);
xlabel('t');
hold on;
plot(t,Y,'-rp','LineWidth',1.5,'MarkerEdgeColor','r','MarkerSize',4);%边缘为红色画出来不太对
legend('原时间序列X1的函数图像','平滑序列Y的函数图像');
title('时间序列X1与平滑序列Y的对比曲线图');
grid on
