clear;
close all;
I=imread('rice.tif');
Imshow(I);
Stru=strel('disk',16);
Back=imopen(I,Stru );
I2=imsubtract(I,Back);
figure, imshow(I2);
Threshold=graythresh(I2);
BW=im2bw(I2,Threshold);
figure, imshow(BW);
[Labeled Number_Object]=bwlabel(BW,8);
GrainData=regionprops(Labeled, 'basic');
    AllGrain=[GrainData.Area];
Max=max(AllGrain)
Mean=mean(AllGrain)