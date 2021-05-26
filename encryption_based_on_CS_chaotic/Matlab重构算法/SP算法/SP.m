% 已知 A 和 y(=Ax) 求 x
% 联系方式：sy1133@163.com
%===========================================


clear; clc

n = 500; % 信号长度
m = 100; % 测量次数 
k = 20;  % 稀疏度

%Generate sparse signal 
z = randperm(n);
x = zeros(n, 1);
x(z(1:k)) = sign(randn(k,1));

A = randn(m,n); % 用于重构的高斯随机矩阵
y = A*x;        % 投影信息：y

alpha = 1; % 如果alpha取2就是CoSaMP算法

r = y; L = []; a_index=[];a_index2=[];
a = zeros(size(x));
iter = 1;
err = 1e-5; % 信号误差

tic
while (iter < 20*k && norm(r)>err)
    
    % Identify
    h = A'* r;
    [h_new,h_index] = sort(abs(h),'descend');
    
    % Merge
    L = union(a_index2,h_index(1:alpha*k));
    
    % Estimate
    a(L) = A(:,L)\y;  
    
    %Prune 
    [a_new,a_index] = sort(abs(a),'descend');
    a(a_index(k+1:end))=0; 
    a_index2 = a_index(1:k);
    
    % Iterate
    r= y - A*a; % r=y-A(:,a_index2)*pinv(A(:,a_index2))*y;
    iter = iter + 1;
    
end
toc

disp(norm(r))
disp(iter)

stem(x,'LineStyle','none')  %原始信号，篮圈
hold on
stem(a,'r','.','LineStyle','none')   %重构后的信号，红点
title('recover')

