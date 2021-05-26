afm = imread('afmsurf.tif');figure, imshow(afm);
se = strel('disk', 15);
Itop = imtophat(afm, se);  % 高帽变换
Ibot = imbothat(afm, se);  % 低帽变换
figure, imshow(Itop, []);   % 高帽变换，体现原始图像的灰度峰值
figure, imshow(Ibot, []);   % 低帽变换，体现原始图像的灰度谷值
Ienhance = imsubtract(imadd(Itop, afm), Ibot);% 高帽图像与低帽图像相减，增强图像
figure, imshow(Ienhance);
Iec = imcomplement(Ienhance); % 进一步增强图像
Iemin = imextendedmin(Iec, 20); figure,imshow(Iemin) % 搜索Iec中的谷值
Iimpose = imimposemin(Iec, Iemin);
wat = watershed(Iimpose);  % 分水岭分割
rgb = label2rgb(wat); figure, imshow(rgb); %  用不同的颜色表示分割出的不同区域
