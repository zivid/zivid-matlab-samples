function [X, Y, Z, R, G, B, Image, Contrast] = zdfread(Filename)

% [X, Y, Z, R, G, B, Image, Contrast] = zdfread(Filename)
%
% Function for reading .ZDF files
%
% INPUT:
% Filename - File to read
%
% OUTPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% R - Red color band from color image (scaled from 0 to 1)
% G - Green color band from color image (scaled from 0 to 1)
% B - Blue color band from color image (scaled from 0 to 1)
% Image - Color image (uint8 - 0 to 255)
% Contrast - Contrast image / quality image (float)

try
    if strcmp(Filename(end-3:end),'.zdf')
        
        disp(['Reading point cloud: ',sprintf('%s',Filename)])
        
        % Reading the color image from rgba_image
        % and spliting in R, G, B normalized matrices.
        RGBA = ncread(Filename,'data/rgba_image');
        RGBA = permute(RGBA,[3 2 1]);

        R = double(RGBA(:,:,1)) / 255;
        G = double(RGBA(:,:,2)) / 255;
        B = double(RGBA(:,:,3)) / 255;

        Image = uint8(RGBA(:,:,1:3));

        % Reading the pointcloud data and creating X, Y, Z matrices.
        Pointcloud = ncread(Filename,'data/pointcloud');
        Pointcloud = permute(Pointcloud,[3 2 1]);

        X = Pointcloud(:,:,1);
        Y = Pointcloud(:,:,2);
        Z = Pointcloud(:,:,3);

        % Reading the contrast / quality data.
        Contrast = ncread(Filename,'data/contrast')';
    else
        disp('Input file is not in ZDF format')
    end
catch ME
    throw(ME)
end

end