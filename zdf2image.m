function zdf2image(filename, outputformat)

% zdf2image(Ffilename, outputformat)
%
% Function for exporting a 2D color image from from a .ZDF file.
%
% INPUT:
% filename - Full folder and filename to ZDF file
% ('MyZDF.zdf', 'MyZDF', 'C:\MyZDF')
%
% OUTPUT
% outputformat - Format of the output file
% ('bmp', 'png', 'jpg', 'jpeg', 'tif', 'tiff')

% Copyright (c) 2019, Zivid AS
%
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the
%    distribution.
%
% 3. Neither the name of Zivid AS nor the names of its contributors may
%    be used to endorse or promote products derived from this software
%    without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY ZIVID AS AND CONTRIBUTORS "AS IS" AND ANY
% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY, AND FITNESS FOR A PARTICULAR
% PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ZIVID AS OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
% BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
% WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
% OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
% IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

if ~strcmp(filename(end-3:end),'.zdf')
    filename = strcat(filename,'.zdf');
end

imo = ncread(filename,'data/rgba_image');
imo = permute(imo,[3 2 1]);
for i=1:3
    im(:,:,i) = imo(:,:,i);
end

FilenameOutput = strcat(filename(1:end-3),outputformat);
imwrite(im,FilenameOutput);

end