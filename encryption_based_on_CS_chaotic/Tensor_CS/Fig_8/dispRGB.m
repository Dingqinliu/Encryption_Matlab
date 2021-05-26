function [] = dispRGB(Y0,mag)
% Y: reflectances tensor
I = size(Y0);
if I(3)==31
    Y = zeros(I(1),I(2),33);
    Y(:,:,1) = Y0(:,:,1);
    Y(:,:,33) = Y0(:,:,31);
    Y(:,:,2:32) = Y0;
else
    Y = Y0;
end

Y = Y/max(Y(:));

%load illum_6500.mat;
%radiances = zeros(size(Y)); % initialize array
%for i = 33
%  radiances(:,:,i) = Y(:,:,i)*illum_6500(i);
%end

radiances = Y;

[r c w] = size(radiances);
radiances = reshape(radiances, r*c, w);

load xyzbar.mat;
XYZ = (xyzbar'*radiances')';

XYZ = reshape(XYZ, r, c, 3);
XYZ = max(XYZ, 0);
XYZ = XYZ/max(XYZ(:));

RGB = XYZ2sRGB_exgamma(XYZ);
RGB = max(RGB, 0);
RGB = min(RGB, 1);

figure; imshow(RGB.^0.4, 'Border','tight','InitialMagnification',mag);

end