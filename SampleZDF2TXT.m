% This example shows how to convert a Zivid point cloud from a .ZDF file
% format to a .TXT file format.

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
FilenameTXT = 'Zivid3D.txt';
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(FilenameZDF);

X = reshape(X', [], 1);
Y = reshape(Y', [], 1);
Z = reshape(Z', [], 1);
R = reshape(R', [], 1);
G = reshape(G', [], 1);
B = reshape(B', [], 1);
Contrast = reshape(Contrast', [], 1);
mask = isnan(X);
X(mask) = [];
Y(mask) = [];
Z(mask) = [];
R(mask) = [];
G(mask) = [];
B(mask) = [];
Contrast(mask) = [];

pts = [X Y Z round(R*255) round(G*255) round(B*255) Contrast];
% pts = [X Y Z];

parts = ceil(length(pts) / 1000000);

%writematrix(pts,FilenameTXT,'Delimiter',' ');
dlmwrite(FilenameTXT,pts,'delimiter',' ','precision','%.3f','newline','pc');
if parts > 1
    for i=1:parts
        index = strfind(FilenameTXT,'.');
        Filename = strcat(FilenameTXT(1:index-1),'_part_',num2str(i),FilenameTXT(index:end));
        last = i*1000000;
        if last > length(pts)
            last = length(pts);
        end
        dlmwrite(Filename,pts(((i-1)*1000000+1):last,:),'delimiter',' ','precision','%.3f','newline','pc');
        %writematrix(pts(((i-1)*1000000+1):last,:),Filename,'Delimiter',' ');
    end
end