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

% Read color image from rgba_image
% and split in R, G, B normalized matrices
imo = ncread(filename,'data/rgba_image');
imo = permute(imo,[3 2 1]);
for i=1:3
    im(:,:,i) = imo(:,:,i);
end

R = double(im(:,:,1)) / 255;
G = double(im(:,:,2)) / 255;
B = double(im(:,:,3)) / 255;

im = uint8(im);

% read pointcloud data and create X, Y, Z matrices
pco = ncread(filename,'data/pointcloud');
pco = permute(pco,[3 2 1]);

X = pco(:,:,1);
Y = pco(:,:,2);
Z = pco(:,:,3);

% Read the contrast / quality data
contrast = ncread(filename,'data/contrast')';

end