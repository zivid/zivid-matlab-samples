function convertZDF(inputFileName,varargin)

% convertZDF(inputFileName,outputFileFormat)
%
% Convert from ZDF to your preferred format
% Example: convertZDF('Zivid3D.zdf','ply')
%
% Available formats:
%     .ply - Polygon File Format
%     .csv,.txt - [x,y,z,r,g,b,snr]
%     .png,.jpg,.bmp,.tiff - 2D RGB image
%
% INPUT:
% inputFileName - ZDF file to convert
% outputFileFormat - File format to convert ZDF file to
%     'ply' - Convert to PLY
%     'csv' - Convert to CSV
%     'txt' - Convert to TXT
%     'jpg' - Covnert to JPEG (3D->2D)
%     'tiff' - Covnert to TIFF (3D->2D)
%     'png' - Covnert to Portable Network Graphics (3D->2D)
%     'bmp' - Covnert to Windows bitmap (3D->2D)

if strcmp(inputFileName(end-3:end),'.zdf')

    for i = 1:nargin-1
        if strcmp(varargin{i},'ply')
            convertToPLY(inputFileName);
        else
            % Reading ZDF frame from file
            [xyz,rgb,snr] = readZDF(inputFileName);
            % Removing extension from file name
            inputFileName = inputFileName(1:end-4);
            if strcmp(varargin{i},'csv')
                convertToCSV(xyz,rgb,snr,strcat(inputFileName,'.csv'));
            elseif strcmp(varargin{i},'txt')
                convertToCSV(xyz,rgb,snr,strcat(inputFileName,'.txt'));
            elseif strcmp(varargin{i},'png')
                convertTo2D(rgb,strcat(inputFileName,'.png'));
            elseif strcmp(varargin{i},'jpg')
                convertTo2D(rgb,strcat(inputFileName,'.jpg'));
            elseif strcmp(varargin{i},'bmp')
                convertTo2D(rgb,strcat(inputFileName,+'.bmp'));
            elseif strcmp(varargin{i},'tiff')
                convertTo2D(rgb,strcat(inputFileName,+'.tiff'));
            end
        end
    end
else
    error('Input file is not in ZDF format');
end

end

function convertToPLY(inputFileName)

% convertToPLY(inputFileName)
%
% Convert to PLY
%
% INPUT:
% inputFileName - File name with extension

% Adding directory that contains zividApplication to search path
addpath(genpath([fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))),filesep,'Camera',filesep,'Basic']));

zivid = zividApplication;

frame = Zivid.NET.Frame(inputFileName);

outputFileName = inputFileName;
outputFileName(end-2:end) = 'ply';

disp('Converting to ply')
frame.Save(outputFileName);

end

function convertToCSV(xyz,rgb,snr,inputFileName)

% convertToCSV(xyz,rgb,snr,inputFileName)
%
% Convert to CSV
%
% INPUT:
% xyz - XYZ data
% rgb - Color image
% snr - Signal-To-Noise
% inputFileName - File name with extension

disp(['Converting to ',inputFileName(end-2:end)]);

x = xyz(:,:,1);
y = xyz(:,:,2);
z = xyz(:,:,3);
r = single(rgb(:,:,1));
g = single(rgb(:,:,2));
b = single(rgb(:,:,3));
mask = ~isnan(x);

pointCloudObject = [x(mask) y(mask) z(mask) r(mask) g(mask) b(mask) snr(mask)];

disp(['Saving data to file: ',inputFileName,', this may take a few minutes']);
dlmwrite(inputFileName,pointCloudObject,'delimiter',',','precision','%.3f','newline','pc');

end

function convertTo2D(rgb,inputFileName)

% convertTo2D(rgb,inputFileName)
%
% Convert to 2D image
%
% INPUT:
% rgb - Color image
% inputFileName - File name with extension

disp(['Converting to ',inputFileName(end-2:end)]);
disp(['Saving image to file: ',inputFileName]);
imwrite(rgb,inputFileName);

end