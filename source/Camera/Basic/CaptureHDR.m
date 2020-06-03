% This example shows how to capture point clouds, with color, from the Zivid camera.
% For scenes with high dynamic range we combine multiple frames to get an HDR point cloud.

try
    zivid = zividApplication;

    disp('Connecting to camera');
    camera = zivid.ConnectCamera;

    disp('Configuring settings'); 
    settings = Zivid.NET.Settings();
    for aperture = [11.31,5.66,2.83]
        disp(['Adding acquisition with aperture = ' num2str(aperture)]);
        acquisitionSettings = Zivid.NET.('Settings+Acquisition');
        acquisitionSettings.Aperture = aperture;
        settings.Acquisitions.Add(acquisitionSettings);
    end

    disp('Capturing frame (HDR)');
    frame = camera.Capture(settings);

    dataFile = 'Frame.zdf';
    disp(['Saving frame to file: ',dataFile]);
    frame.Save(dataFile);

    disp('Disconnecting from camera');
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end