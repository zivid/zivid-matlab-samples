% Downsample point cloud from ZDF file.

try
    % Adding directories that contains zividApplication and zdfread to search path
    addpath(genpath([fileparts(fileparts(fileparts(mfilename('fullpath')))),filesep,'Camera',filesep,'Basic']));
    addpath(genpath([fileparts(fileparts(mfilename('fullpath'))),filesep,'Basic',filesep,'FileFormats']));

    zivid = zividApplication;

    dataFile = [char(System.Environment.GetFolderPath(System.('Environment+SpecialFolder.CommonApplicationData'))),'/Zivid/Zivid3D.zdf'];
    disp(['Reading ZDF frame from file: ',dataFile]);
    frame = Zivid.NET.Frame(dataFile);
    ptCloud = frame.PointCloud();

    xyz = single(ptCloud.CopyPointsXYZ);
    rgba = uint8(ptCloud.CopyColorsRGBA);
    rgb = rgba(:,:,1:3);

    ptCloudOriginal = pointCloud(xyz,'color',rgb);

    disp(['Size of point cloud before downsampling: ', num2str(ptCloud.Size), ' data points']);

    ptCloud.Downsample(Zivid.NET.('PointCloud+Downsampling.By2x2'));

    disp(['Size of point cloud after downsampling: ', num2str(ptCloud.Size), ' data points']);

    xyzDownsampled = single(ptCloud.CopyPointsXYZ);
    rgbaDownsampled = uint8(ptCloud.CopyColorsRGBA);
    rgbDownsampled = rgbaDownsampled(:,:,1:3);

    ptCloudDownsampled = pointCloud(xyzDownsampled,'color',rgbDownsampled);

    disp('Visualizing original and downsampled RGB image and depth map');
    figure('units','normalized','outerposition',[0,0,1,1]);
    subplot(2,2,1);
    imagesc(rgb);
    subplot(2,2,2);
    imagesc(rgbDownsampled);
    subplot(2,2,3);
    imagesc(xyz(:,:,3));
    colormap jet;
    colorbar;
    subplot(2,2,4);
    imagesc(xyzDownsampled(:,:,3));
    colormap jet;
    colorbar;
    [height,width, ~] = size(rgb);
    pbaspect([width,height,1]);

    disp('Visualizing original and downsampled point cloud');
    figure('units','normalized','outerposition',[0,0,1,1]);
    pcshow(ptCloudOriginal);
    view([0,-90]);
    set(gca,'visible','off');
    figure('units','normalized','outerposition',[0,0,1,1]);
    pcshow(ptCloudDownsampled);
    view([0,-90]);
    set(gca,'visible','off');

catch ex

    throw(ex)

end
