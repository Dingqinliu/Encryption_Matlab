
function [] = MakeFig8()

clear all
clc

load BOMPresults33.mat

load ../Datasets/Hyperspectral/ref_cyflower1bb_reg1.mat
I0 = zeros(1024,1024,32);
I0(1:1017,:,:) = reflectances(1:1017,1:1024,2:33);
for i=1018:1024
    I0(i,:,:) = I0(i-1,:,:);
end

clear 'reflectances'

div = 2; 

rangerow = 625:625+150-1;
rangecol = 750:750+150-1;
L1 = length(rangerow);
L2 = length(rangecol);

%% 
I0 = I0(:,:,1:31);
dispRGB(I0,25);
title({['Original Hyperspectral Image (1024x1024x32),RGB display']});

%%
dispRGB(I0(rangerow,rangecol,:),170);
title({['Zoom Original (150x150x32) (RGB display)']});

%%
AproxtensorOMP = AproxtensorOMP(:,:,1:31);
dispRGB(AproxtensorOMP,25);
title({['N-BOMP: Reconstructed Image (1024x1024x32), RGB display, PSNR=',num2str(PSNRNBOMP),'dB']});

%%
dispRGB(AproxtensorOMP(rangerow,rangecol,:),170);
title({['Zoom Reconstruction (150x150x32) (RGB display)']});

end