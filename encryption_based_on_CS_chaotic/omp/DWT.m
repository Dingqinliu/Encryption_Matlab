%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，登录淘宝店铺“大成软件工作室”，可以下载(????)1分钱成品代码(′▽`〃)哦~
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了(づ??????)づ
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭?～
%   传送门：https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)

function ww=DWT(N)

[h,g]= wfilters('sym8','d');       %  分解低通和高通滤波器

% N=256;                           %  矩阵维数(大小为2的整数幂次)
L=length(h);                       %  滤波器长度
rank_max=log2(N);                  %  最大层数
rank_min=double(int8(log2(L)))+1;  %  最小层数
ww=1;   %  预处理矩阵

%  矩阵构造
for jj=rank_min:rank_max
    
    nn=2^jj;
    
    %  构造向量
    p1_0=sparse([h,zeros(1,nn-L)]);
    p2_0=sparse([g,zeros(1,nn-L)]);
    
    %  向量圆周移位
    for ii=1:nn/2
        p1(ii,:)=circshift(p1_0',2*(ii-1))';
        p2(ii,:)=circshift(p2_0',2*(ii-1))';
    end
    
    %  构造正交矩阵
    w1=[p1;p2];
    mm=2^rank_max-length(w1);
    w=sparse([w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)]);
    ww=ww*w;
    
    clear p1;clear p2;
end
