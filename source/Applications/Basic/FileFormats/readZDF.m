function [xyz,rgb,snr] = readZDF(dataFile)

    % [xyz,rgba,snr] = readZDF(dataFile)
    %
    % Read ZDF file
    %
    % INPUT:
    % dataFile - ZDF file to read
    %
    % OUTPUT:
    % xyz - XYZ data in a matrix
    % rgb - Color image (uint8 - 0 to 255)
    % snr - Signal-To-Noise in a matrix

    try
        [~, ~, ext] = fileparts(dataFile);
        disp(dataFile)
        if strcmpi(ext,'.zdf')

            % Adding directory that contains zividApplication to search path
            addpath(genpath([fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))),filesep,'Camera',filesep,'Basic']));

            zivid = zividApplication;

            disp('Getting point cloud from frame');
            frame = Zivid.NET.Frame(dataFile);
            xyz = single(frame.PointCloud.CopyPointsXYZ);
            rgba = uint8(frame.PointCloud.CopyColorsRGBA);
            rgb = rgba(:,:,1:3);
            snr = single(frame.PointCloud.CopySNRs);

        else
            error('Input file is not in ZDF format');
        end
    catch ME
        throw(ME);
    end

end
