function [ Phi ] = CirculantMtx( M,N )
%CirculantMtx Summary of this function goes here
%   Generate Circulant matrix 
%   M -- RowNumber
%   N -- ColumnNumber
%   Phi -- The Circulant matrix

%% Generate a random vector
%     %(1)Gauss
%     u = randn(1,N);
    %(2)Bernoulli
    u = randi([0,1],1,N);%�ڿ����䣨0��1��֮���������1��N����ģ���������
    u(u==0) = -1;%ʲĪ��˼
%% Generate Circulant matrix   
    Phi_t = toeplitz(circshift(u,[1,1]),fliplr(u(1:N)));%��u�������¸���һλ
                 %ʹ�� toeplitz ������u����ѭ������
    Phi = Phi_t(1:M,:);%ѭ��M�Σ��õ�M��N�ľ���
end