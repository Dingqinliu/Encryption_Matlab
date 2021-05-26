afm = imread('afmsurf.tif');figure, imshow(afm);
se = strel('disk', 15);
Itop = imtophat(afm, se);  % ��ñ�任
Ibot = imbothat(afm, se);  % ��ñ�任
figure, imshow(Itop, []);   % ��ñ�任������ԭʼͼ��ĻҶȷ�ֵ
figure, imshow(Ibot, []);   % ��ñ�任������ԭʼͼ��ĻҶȹ�ֵ
Ienhance = imsubtract(imadd(Itop, afm), Ibot);% ��ñͼ�����ñͼ���������ǿͼ��
figure, imshow(Ienhance);
Iec = imcomplement(Ienhance); % ��һ����ǿͼ��
Iemin = imextendedmin(Iec, 20); figure,imshow(Iemin) % ����Iec�еĹ�ֵ
Iimpose = imimposemin(Iec, Iemin);
wat = watershed(Iimpose);  % ��ˮ��ָ�
rgb = label2rgb(wat); figure, imshow(rgb); %  �ò�ͬ����ɫ��ʾ�ָ���Ĳ�ͬ����
