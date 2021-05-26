function dNMSE = nmse(ImageA,ImageB)
% 计算nmse(归一化均方差)
% ImageA:第一幅图像
% ImageB:第二幅图像
% dNMSE:根据两幅图像，计算归一化均方差

if (size(ImageA,1) ~= size(ImageB,1)) or (size(ImageA,2) ~= size(ImageB,2))
    error('ImageA <> ImageB');
    dNMSE = 0;
    return ;
end
ImageA=double(ImageA);
ImageB=double(ImageB);
M = size(ImageA,1);
N = size(ImageA,2);
d1 = 0;
d2 = 0;
for i = 1:M
    for j = 1:N
        d1 = d1 + (ImageA(i,j) - ImageB(i,j)).^2;
        d2 = d2 + ImageA(i,j).^2;
    end
end
dNMSE = d1/d2;
return