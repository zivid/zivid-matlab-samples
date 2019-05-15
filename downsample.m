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

% Author: Martin Ingvaldsen

% BSD 3-Clause License
% 
% Copyright (c) 2019, Zivid AS
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived from
%    this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%% Check if dsf is ok
[h,w,d] = size(Image);

if mod(dsf,2) ~= 0 || mod(h,dsf) || mod(w,dsf)
    disp('Downsampling factor - dsf has to have one of the following values: 2, 3, 4, 5, 6.\n');
end

%% downsample by sum algorithm

% Reshape and sum in first direction
% sumline = @(matrix,dsf) (reshape(nansum(reshape(matrix,dsf,[]),1),size(matrix,1)/dsf,size(matrix,2)));
sumline = @(matrix,dsf) (reshape(sum(reshape(matrix,dsf,[]),1,'omitnan'),size(matrix,1)/dsf,size(matrix,2)));
% repeat for second direction
gridsum = @(matrix,dsf) (sumline(sumline(matrix,dsf)',dsf)');

%% Do image

for i = 1:d
    Image_new(:,:,i) = uint8(gridsum(Image(:,:,i),dsf)/dsf^2);
end

%% Do contrast for weight

Contrast(isnan(Z)) = 0;
contrastWeigth = gridsum(Contrast,dsf);

%% Do weighted downsample on X, Y and Z

X_new = gridsum(X.*Contrast,dsf)./contrastWeigth;
Y_new = gridsum(Y.*Contrast,dsf)./contrastWeigth;
Z_new = gridsum(Z.*Contrast,dsf)./contrastWeigth;

end