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
    u = randi([0,1],1,N);%在开区间（0，1）之间随机生成1×N矩阵的，即行向量
    u(u==0) = -1;%什莫意思
%% Generate Circulant matrix   
    Phi_t = toeplitz(circshift(u,[1,1]),fliplr(u(1:N)));%将u向右向下各移一位
                 %使用 toeplitz 从向量u创建循环矩阵
    Phi = Phi_t(1:M,:);%循环M次，得到M×N的矩阵
end