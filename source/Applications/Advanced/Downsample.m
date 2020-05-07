% Import ZDF point cloud and downsample it.

% The "Zivid3D.zdf" file has to be in the same folder as the "ReadZDF" file.
Filename = [char(Zivid.NET.Environment.DataPath), '/Zivid3D.zdf'];

% Adding directory that contains zdfread to search path.
addpath(genpath([fileparts(pwd), filesep, 'Basic']));

% Reading a .ZDF point cloud.
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(Filename);

% Creating a point cloud object.
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;
pc=pointCloud(XYZ,'color',double(Image)./255);

% Downsampling the point cloud.
[X_new,Y_new,Z_new,Image_new] = downsample(X,Y,Z,Image,Contrast,4);
XYZ_new(:,:,1) = X_new;
XYZ_new(:,:,2) = Y_new;
XYZ_new(:,:,3) = Z_new;
pc_new = pointCloud(XYZ_new,'color',double(Image_new)./255);

% Displaying RGB and Depth images.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
imagesc(Image);
subplot(2,2,2)
imagesc(Image_new);
subplot(2,2,3)
imagesc(Z);
colormap jet
colorbar
subplot(2,2,4)
imagesc(Z_new);
colormap jet
colorbar
pbaspect([1920 1200 1])

%Visualizing the point clouds.
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc);
view([0 -90]);
set(gca, 'visible', 'off')
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc_new);
view([0 -90]);
set(gca, 'visible', 'off')

function [X_new, Y_new, Z_new, Image_new] = downsample(X, Y, Z, Image, Contrast, dsf)

% [X_new, Y_new, Z_new, Image_new] = downsample(X, Y, Z, Image, Contrast, dsf)
%
% Function for downsampling a Zivid point cloud
%
% INPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% Image - Color image (uint8 - 0 to 255)
% Contrast - Contrast image / quality image (float)
% dsf - Downsampling factor (values: 1,2,3,4,5,6) represents the
% denominator of a fraction that represents the size of the downsampled
% point cloud relative to the original point cloud, e.g. 2 - one-half,
% 3 - one-third, 4 one-quarter, etc.
%
% OUTPUT:
% X_new - Downsampled x data in a matrix
% Y_new - Downsampled y data in a matrix
% Z_new - Downsampled z data in a matrix
% Image_new - Downsampled Color image (uint8 - 0 to 255)

%% Checking if dsf is ok.
[h,w,d] = size(Image);

if mod(h,dsf) || mod(w,dsf)
    disp('Downsampling factor has to be a factor of the point cloud width (1920) and height (1200).\n');
end

%% Downsampling by sum algorithm.

% Reshape and sum in first direction.
sumline = @(matrix,dsf) (reshape(sum(reshape(matrix,dsf,[]),1,'omitnan'),size(matrix,1)/dsf,size(matrix,2)));
% repeat for second direction.
gridsum = @(matrix,dsf) (sumline(sumline(matrix,dsf)',dsf)');

for i = 1:d
    Image_new(:,:,i) = uint8(gridsum(Image(:,:,i),dsf)/dsf^2);
end

Contrast(isnan(Z)) = 0;
contrastWeight = gridsum(Contrast,dsf);

X_new = gridsum(X.*Contrast,dsf)./contrastWeight;
Y_new = gridsum(Y.*Contrast,dsf)./contrastWeight;
Z_new = gridsum(Z.*Contrast,dsf)./contrastWeight;

end