%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%           综合过程

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  BR = WavRecov(BW,Hr1,Hr2,dim)
N = size(BW,1);
SL = N/2^(dim-1);
WD = BW(SL/2+1:SL,SL/2+1:SL);
WV = BW(SL/2+1:SL,1:SL/2);
WH = BW(1:SL/2,SL/2+1:SL);
WF = BW(1:SL/2,1:SL/2);
BR = WavRecovs(WD,WV,WH,WF,Hr1,Hr2);
for i = 2:dim
    WF = BR;
    SL = size(BR,1);
    WD = BW(SL+1:2*SL,SL+1:2*SL);
    WV = BW(SL+1:2*SL,1:SL);
    WH = BW(1:SL,SL+1:2*SL);
    BR = WavRecovs(WD,WV,WH,WF,Hr1,Hr2);    
end
% BR = BDH(BR);



function BW = WavRecovs(WD,WV,WH,WF,H1,H2)
IM1 = WaveRecr(WD,H1); IM2 = WaveRecr(WV,H2);
IM12 = IM1 + IM2;
IM3 = WaveRecr(WH,H1); IM4 = WaveRecr(WF,H2);
IM34 = IM3 + IM4;
CM1 = WaveRecc(IM12,H1);
CM2 = WaveRecc(IM34,H2);
BW = CM1+CM2;


function  BR = WaveRecr(WD,Hs) 
%  按行插 按列卷
[N M] = size(WD);
IW = zeros(2*N,M);IW(1:2:2*N,1:M) = WD;
Hst = zeros(1,2*N);Hst(1:length(Hs))=Hs; Hsf=fft(Hst);
BR = zeros(size(IW));
for i=1:M
    BR(:,i) = ifft(fft(IW(:,i)).*(Hsf.'));
end

function  BC = WaveRecc(WD,Hs)
% 按列插 按行卷
[N M] = size(WD);
IW = zeros(N,2*M);IW(1:N,1:2:2*M) = WD;
Hst = zeros(1,2*M);Hst(1:length(Hs))=Hs; Hsf=fft(Hst);
BC = zeros(size(IW));
for i=1:N
    BC(i,:) = ifft(fft(IW(i,:)).*Hsf);
end

