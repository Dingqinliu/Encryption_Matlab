%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                       �ֽ����
%
%   WavletDim ����Dim����H1��H2ΪС���߶ȵĽ��� XΪԭͼתdouble
%   myWavlet ��֧�߽���ʵ��
%   BDH   ��������ͼ����ʾ�����б궨��

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
% ��һ�� �о��г�
W1 = zeros(size(X));
for i=1:N
    W1(i,:)=ifft(fft(X(i,:)).*H1f);
end 
W2 = W1(:,2:2:M);
% �ڶ��� �о��г�
H2t = zeros(1,N); H2t(1:length(H2)) = H2;
H2f =fft(H2t);

for i=1:M/2
    W2(:,i)=ifft(fft(W2(:,i)).*(H2f.'));
end
BW = W2(2:2:N,:);





