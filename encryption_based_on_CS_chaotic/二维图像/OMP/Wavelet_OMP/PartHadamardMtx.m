function [ Phi ] = PartHadamardMtx( M,N )
%PartHadamardMtx Summary of this function goes here
%   Generate part Hadamard matrix 
%   M -- RowNumber
%   N -- ColumnNumber
%   Phi -- The part Hadamard matrix

%% parameter initialization
%Because the MATLAB function hadamard handles only the cases where n, n/12,
%or n/20 is a power of 2
    L_t = max(M,N);%Maybe L_t does not meet requirement of function hadamard
    L_t1 = (12 - mod(L_t,12)) + L_t;
    L_t2 = (20 - mod(L_t,20)) + L_t; 
    L_t3 = 2^ceil(log2(L_t));
    L = min([L_t1,L_t2,L_t3]);%Get the minimum L
%% Generate part Hadamard matrix   
    Phi = [];
    Phi_t = hadamard(L);
    RowIndex = randperm(L);
    Phi_t_r = Phi_t(RowIndex(1:M),:);
    ColIndex = randperm(L);
    Phi = Phi_t_r(:,ColIndex(1:N));
end