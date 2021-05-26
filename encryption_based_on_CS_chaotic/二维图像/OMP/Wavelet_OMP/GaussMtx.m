function [ Phi ] = GaussMtx( M,N )
%GaussMtx Summary of this function goes here
%   Generate Bernoulli matrix 
%   M -- RowNumber
%   N -- ColumnNumber
%   Phi -- The Gauss matrix

%% Generate Gauss matrix   
    Phi = randn(M,N);
    %Phi = Phi/sqrt(M);
end