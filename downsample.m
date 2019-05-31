function [X_new, Y_new, Z_new, Image_new] = downsample(X, Y, Z, Image, Contrast, dsf)

% [X_new, Y_new, Z_new, Image_new] = downsample(X, Y, Z, Image, Contrast, dsf)
%
% Function for downsampling a Zivid point cloud
%
% INPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% R - Red color band from color image (scaled from 0 to 1)
% G - Green color band from color image (scaled from 0 to 1)
% B - Blue color band from color image (scaled from 0 to 1)
% Image - Color image (uint8 - 0 to 255)
% Contrast - Contrast image / quality image (float)
% dsf - Downsampling factor (values: 1,2,3,4,5,6) represents the
% denominator of a fraction that represents the size of the downsampled
% point cloud relative to the original point cloud, e.g. 2 - one-half,
% 3 - one-third, 4 one-quarter, etc.
%
% OUTPUT:
% pc_new - Downsampled Pointcloud (for use by pcshow and other MATLAB specific functions)
% X_new - Downsampled x data in a matrix
% Y_new - Downsampled y data in a matrix
% Z_new - Downsampled z data in a matrix
% R_new - Downsampled Red color band from color image (scaled from 0 to 1)
% G_new - Downsampled Green color band from color image (scaled from 0 to 1)
% B_new - Downsampled Blue color band from color image (scaled from 0 to 1)
% Image_new - Downsampled Color image (uint8 - 0 to 255)

%% Checking if dsf is ok
[h,w,d] = size(Image);

if mod(dsf,2) ~= 0 || mod(h,dsf) || mod(w,dsf)
    disp('Downsampling factor - dsf has to have one of the following values: 2, 3, 4, 5, 6.\n');
end

%% Downsampling by sum algorithm

% Reshape and sum in first direction
sumline = @(matrix,dsf) (reshape(sum(reshape(matrix,dsf,[]),1,'omitnan'),size(matrix,1)/dsf,size(matrix,2)));
% repeat for second direction
gridsum = @(matrix,dsf) (sumline(sumline(matrix,dsf)',dsf)');

%% Doing image

for i = 1:d
    Image_new(:,:,i) = uint8(gridsum(Image(:,:,i),dsf)/dsf^2);
end

%% Doing contrast for weight

Contrast(isnan(Z)) = 0;
contrastWeigth = gridsum(Contrast,dsf);

%% Doing weighted downsample on X, Y and Z

X_new = gridsum(X.*Contrast,dsf)./contrastWeigth;
Y_new = gridsum(Y.*Contrast,dsf)./contrastWeigth;
Z_new = gridsum(Z.*Contrast,dsf)./contrastWeigth;

end