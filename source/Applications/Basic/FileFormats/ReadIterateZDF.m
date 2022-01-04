% Read point cloud data from a ZDF file, iterate through it, and extract individual points.

% The ZDF file for this sample can be found under the main instructions for Zivid samples.

try
    % Adding directory that contains zividApplication to search path
    addpath(genpath([fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))),filesep,'Camera',filesep,'Basic']));

    zivid = zividApplication;

    dataFile = [char(System.Environment.GetFolderPath(System.('Environment+SpecialFolder.CommonApplicationData'))),'/Zivid/Zivid3D.zdf'];
    disp(['Reading ZDF frame from file: ',dataFile]);
    [xyz,rgb,snr] = readZDF(dataFile);

    ptCloud = pointCloud(xyz,'color',rgb);

    [height, width, ~] = size(ptCloud.Location);
    disp('Point cloud information:');
    disp(['Number of points: ',num2str(ptCloud.Count)]);
    disp(['Height: ',num2str(height)]);
    disp(['Width: ',num2str(width)]);

    pixelsToDisplay = 10;
    disp(['Iterating over point cloud and extracting X,Y,Z,R,G,B,and snr for central ',num2str(pixelsToDisplay),' x ',num2str(pixelsToDisplay),' pixels']);
    iStart = (height - pixelsToDisplay) / 2;
    iStop = (height + pixelsToDisplay) / 2;
    jStart = (width - pixelsToDisplay) / 2;
    jStop = (width + pixelsToDisplay) / 2;
    for i = iStart:iStop
        for j = jStart:jStop
            disp(['Values at pixel (',num2str(i),' ,',num2str(j),'):  X: ',pad(num2str(ptCloud.Location(i,j,1),'%.1f'),7),' Y: ',pad(num2str(ptCloud.Location(i,j,2),'%.1f'),7),' Z: ',pad(num2str(ptCloud.Location(i,j,3),'%.1f'),7),' R: ',pad(num2str(ptCloud.Color(i,j,1)),7),' G: ',pad(num2str(ptCloud.Color(i,j,2)),7),' B: ',pad(num2str(ptCloud.Color(i,j,3)),7),' snr: ',pad(num2str(snr(i,j),'%.1f'),7)]);
        end
    end

    disp('Visualizing RGB image');
    figure('units','normalized','outerposition',[0,0,1,1]);
    imagesc(rgb);
    pbaspect([width,height,1]);

    disp('Visualizing depth map');
    figure('units','normalized','outerposition',[0,0,1,1]);
    imagesc(xyz(:,:,3));
    pbaspect([width,height,1]);
    colormap jet;
    colorbar;

    disp('Visualizing point cloud');
    figure('units','normalized','outerposition',[0,0,1,1]);
    pcshow(ptCloud);
    view([0,-90]);
    set(gca,'visible','off');

catch ex

    throw(ex)

end
