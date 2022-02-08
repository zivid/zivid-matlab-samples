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
        for i = 1:nargin - 1
            switch varargin{i}
                case 'ply'
                    convertToPLY(inputFileName);
                case {'csv', 'txt'}
                    convertToCSV(inputFileName,varargin{i});
                case {'png', 'jpg', 'bmp', 'tiff'}
                    convertTo2D(inputFileName,varargin{i});
                otherwise
                    error(['Format "', varargin{i}, '" not recognised']);
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

function convertToCSV(inputFileName,extension)

    % convertToCSV(xyz,rgb,snr,inputFileName)
    %
    % Convert to CSV
    %
    % INPUT:
    % inputFileName - File name with extension
    % extension - File extension, 'csv' or 'txt'

    disp(['Converting to ', extension]);

    [~, name, ~] = fileparts(inputFileName);
    outputFileName = [name, '.', extension];

    % Reading ZDF frame from file
    [xyz,rgb,snr] = readZDF(inputFileName);

    x = xyz(:,:,1);
    y = xyz(:,:,2);
    z = xyz(:,:,3);
    r = single(rgb(:,:,1));
    g = single(rgb(:,:,2));
    b = single(rgb(:,:,3));
    mask = ~isnan(x);

    pointCloudObject = [x(mask),y(mask),z(mask),r(mask),g(mask),b(mask),snr(mask)];

    disp(['Saving data to file: ',outputFileName,', this may take a few minutes']);
    dlmwrite(outputFileName,pointCloudObject,'delimiter',',','precision','%.3f','newline','pc');

end

function convertTo2D(inputFileName,extension)

    % convertTo2D(rgb,inputFileName)
    %
    % Convert to 2D image
    %
    % INPUT:
    % inputFileName - File name with extension
    % extension - File extension, 'png', 'jpg', 'bmp' or 'tiff'

    disp(['Converting to ', extension]);

    [~, name, ~] = fileparts(inputFileName);
    outputFileName = [name, '.', extension];
    disp(['Saving 2D color image to file: ',outputFileName]);

    % Reading ZDF frame from file
    [~, rgb, ~] = readZDF(inputFileName);
    imwrite(rgb,outputFileName);

end
