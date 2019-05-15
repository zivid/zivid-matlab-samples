% This example shows how to convert a Zivid point cloud from a .ZDF file
% format to a .PLY file format.

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

% Read a .ZDF point cloud. The "Zivid3D.zdf" file has to be in the same folder as the "SampleReadZDF" file.
FilenameZDF = 'Zivid3D.zdf';
FilenamePLY = 'Zivid3D.ply';
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(FilenameZDF);

% Create a point cloud
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;

% Replace NaNs with Zeros
XYZ(isnan(XYZ)) = 0;

% Switch rows and columns
XYZ = permute(conj(XYZ),[2,1,3]);
Image = permute(conj(Image),[2,1,3]);

% Create a point cloud object
pc = pointCloud(XYZ,'color',Image);

% Save to a .PLY file format
pcwrite(pc,FilenamePLY,'Encoding','binary');