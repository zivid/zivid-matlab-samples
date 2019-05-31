function [X, Y, Z, R, G, B, im, contrast] = zdfread(filename)

% [X, Y, Z, R, G, B, im, contrast] = zdfread(filename)
%
% Function for reading .ZDF files
%
% INPUT:
% filename - Full folder and filename to ZDF file
%
% OUTPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% R - Red color band from color image (scaled from 0 to 1)
% G - Green color band from color image (scaled from 0 to 1)
% B - Blue color band from color image (scaled from 0 to 1)
% im - Color image (uint8 - 0 to 255)
% contrast - Contrast image / quality image (float)

% Reading color image from rgba_image
% and spliting in R, G, B normalized matrices
imo = ncread(filename,'data/rgba_image');
imo = permute(imo,[3 2 1]);
for i=1:3
    im(:,:,i) = imo(:,:,i);
end

R = double(im(:,:,1)) / 255;
G = double(im(:,:,2)) / 255;
B = double(im(:,:,3)) / 255;

im = uint8(im);

% Reading pointcloud data and create X, Y, Z matrices
pco = ncread(filename,'data/pointcloud');
pco = permute(pco,[3 2 1]);

X = pco(:,:,1);
Y = pco(:,:,2);
Z = pco(:,:,3);

% Reading the contrast / quality data
contrast = ncread(filename,'data/contrast')';

end