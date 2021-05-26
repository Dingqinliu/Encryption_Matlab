% ��֪ A �� y(=Ax) �� x
% ��ϵ��ʽ��sy1133@163.com
%===========================================


clear; clc

n = 500; % �źų���
m = 100; % �������� 
k = 20;  % ϡ���

%Generate sparse signal 
z = randperm(n);
x = zeros(n, 1);
x(z(1:k)) = sign(randn(k,1));

A = randn(m,n); % �����ع��ĸ�˹�������
y = A*x;        % ͶӰ��Ϣ��y

alpha = 1; % ���alphaȡ2����CoSaMP�㷨

r = y; L = []; a_index=[];a_index2=[];
a = zeros(size(x));
iter = 1;
err = 1e-5; % �ź����

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

stem(x,'LineStyle','none')  %ԭʼ�źţ���Ȧ
hold on
stem(a,'r','.','LineStyle','none')   %�ع�����źţ����
title('recover')

