
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
function [ Phi ] = PartHadamardMtx( M,N,r,x0,d)
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
    n=d*2*L;
    s0=zeros(1,n);
s0=LT(r,x0,n);
 b=s0(1:10:n);
 a=length(b);
 for j=1:a
     s1=b(1:256);
     s2=b(a-255:end);
 end 
 %s1=s1(1:M);
[~,u2]=sort(s1);
[~,v2]=sort(s2);
    RowIndex = u2;
    Phi_t_r = Phi_t(RowIndex(1:M),:);
    ColIndex = v2;
    Phi = Phi_t_r(:,ColIndex(1:N));
end



