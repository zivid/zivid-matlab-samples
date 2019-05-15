% This example shows how to import a Zivid point cloud from a .ZDF file.

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

%Read a .ZDF point cloud. The "Zivid3D.zdf" file has to be in the same folder as the "SampleReadZDF" file.
Filename = 'Zivid3D.zdf';
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(Filename);

% Create a point cloud object
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;
pc=pointCloud(XYZ,'color',double(Image)./255);

%Display the RGB image
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(Image);
pbaspect([1920 1200 1])

%Display the Z component
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(Z);
pbaspect([1920 1200 1])
colormap jet
colorbar

%Visualize the point cloud
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc);
view([0 -90]);
set(gca, 'visible', 'off')