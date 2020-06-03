% This example shows how to downsample point cloud from ZDF file.

% Adding directories that contains zividApplication and zdfread to search path
addpath(genpath([fileparts(fileparts(fileparts(mfilename('fullpath')))),filesep,'Camera',filesep,'Basic']));
addpath(genpath([fileparts(fileparts(mfilename('fullpath'))),filesep,'Basic',filesep,'FileFormats']));

% Clearing variables to enable running the sample multiple times
clearvars -except zivid;

zivid = zividApplication;

dataFile = [char(System.Environment.GetFolderPath(System.('Environment+SpecialFolder.CommonApplicationData'))),'/Zivid/Zivid3D.zdf'];
disp(['Reading ZDF frame from file: ',dataFile]);
[xyz,rgb,snr] = readZDF(dataFile);

pointCloudOriginal = pointCloud(xyz,'color',rgb);

downsamplingFactor = 4;
disp(['Downsampling point cloud with factor ',num2str(downsamplingFactor)]);
[xyzDownsampled,rgbDownsampled] = downsample(xyz,rgb,snr,downsamplingFactor);

pointCloudDownsampled = pointCloud(xyzDownsampled,'color',rgbDownsampled);

disp('Visualizing original and downsampled RGB image and depth map');
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1);
imagesc(rgb);
subplot(2,2,2);
imagesc(rgbDownsampled);
subplot(2,2,3);
imagesc(xyz(:,:,3));
colormap jet;
colorbar;
subplot(2,2,4);
imagesc(xyzDownsampled(:,:,3));
colormap jet;
colorbar;
[height,width,~] = size(rgb);
pbaspect([width height 1]);

disp('Visualizing original and downsampled point cloud');
figure('units','normalized','outerposition',[0 0 1 1]);
pcshow(pointCloudOriginal);
view([0 -90]);
set(gca,'visible','off');
figure('units','normalized','outerposition',[0 0 1 1]);
pcshow(pointCloudDownsampled);
view([0 -90]);
set(gca,'visible','off');

function [xyzDownsampled,rgbDownsampled] = downsample(xyz,rgb,snr,downsamplingFactor)

% [xyzDownsampled,rgbDownsampled] = downsample(xyz,rgb,snr,downsamplingFactor)
%
% Downsample point cloud
%
% INPUT:
% xyz - XYZ data in a matrix
% rgb - Color image (uint8 - 0 to 255)
% snr - Signal-To-Noise in a matrix
% downsamplingFactor - Downsampling factor (values: 1,2,3,4,5,6)
% represents the % denominator of a fraction that represents the size of
% the downsampled point cloud relative to the original point cloud,e.g.
% 2 - one-half,% 3 - one-third,4 one-quarter,etc.
%
% OUTPUT:
% xyzDownsampled - Downsampled XYZ data in a matrix
% rgbDownsampled - Downsampled Color image (uint8 - 0 to 255)

%% Checking if downsamplingFactor is ok
[height,width,dimension] = size(rgb);

if mod(height,downsamplingFactor) || mod(width,downsamplingFactor)
    error(['Downsampling factor has to be a factor of the point cloud width (',num2str(width),') and height (',num2str(height),')']);
end

%% Downsampling by sum algorithm

% Reshaping and summing in first direction
sumline = @(matrix,downsamplingFactor) (reshape(sum(reshape(matrix,downsamplingFactor,[]),1,'omitnan'),size(matrix,1)/downsamplingFactor,size(matrix,2)));
% Repeating for second direction
gridsum = @(matrix,downsamplingFactor) (sumline(sumline(matrix,downsamplingFactor)',downsamplingFactor)');

rgbDownsampled = uint8(zeros(height/downsamplingFactor,width/downsamplingFactor,3));
for i = 1:dimension
    rgbDownsampled(:,:,i) = uint8(gridsum(rgb(:,:,i),downsamplingFactor)/downsamplingFactor^2);
end

snr(isnan(xyz(:,:,1))) = 0;
snrWeight = gridsum(snr,downsamplingFactor);

xyzDownsampled = single(zeros(height/downsamplingFactor,width/downsamplingFactor,3));
for i = 1:3
    xyzDownsampled(:,:,i) = gridsum(xyz(:,:,i).*snr,downsamplingFactor)./snrWeight;
end

end