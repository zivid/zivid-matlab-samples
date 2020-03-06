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