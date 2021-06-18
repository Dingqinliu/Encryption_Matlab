%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                       分解过程
%
%   WavletDim 进行Dim级以H1，H2为小波尺度的降解 X为原图转double
%   myWavlet 单支线降解实现
%   BDH   更有利于图像显示，进行标定话

function BWS = WavletDim(X,H1,H2,dim)
WF = X;
[BWS WD WV WH WS] = myWavlet(WF,H1,H2);
for i = 2:dim
    WF = WS;
    [BW WD WV WH WS] = myWavlet(WF,H1,H2);
    Lo = size(BW,1);
    BWS(1:Lo,1:Lo) = BW;
end

function [BW WD WV WH WF] = myWavlet(X,H1,H2)
    WD = myWavSb(X,H1,H1);
    WV = myWavSb(X,H1,H2);
    WH = myWavSb(X,H2,H1);
    WF = myWavSb(X,H2,H2);
    BW = [WF WH;WV WD];



function BW = myWavSb(X,H1,H2)
[N M] = size(X);
H1t = zeros(1,M); H1t(1:length(H1)) = H1;
H1f = fft(H1t);
% 第一级 行卷列抽
W1 = zeros(size(X));
for i=1:N
    W1(i,:)=ifft(fft(X(i,:)).*H1f);
end 
W2 = W1(:,2:2:M);
% 第二级 列卷行抽
H2t = zeros(1,N); H2t(1:length(H2)) = H2;
H2f =fft(H2t);

for i=1:M/2
    W2(:,i)=ifft(fft(W2(:,i)).*(H2f.'));
end
BW = W2(2:2:N,:);





