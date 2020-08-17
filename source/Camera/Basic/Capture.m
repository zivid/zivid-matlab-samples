% This example shows how to capture point clouds, with color, from the Zivid camera.

try
    zivid = zividApplication; 

    disp('Connecting to camera');
    camera = zivid.ConnectCamera;

    disp('Configuring settings');
    acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
    acquisitionSettings.Aperture = 5.66;
    acquisitionSettings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(6500);

    settings = Zivid.NET.Settings();
    settings.Processing.Filters.Outlier.Removal.Enabled = true;
    settings.Processing.Filters.Outlier.Removal.Threshold = 5.0;
    settings.Acquisitions.Add(acquisitionSettings);

    disp('Capturing frame');
    frame = camera.Capture(settings);

    dataFile = 'Frame.zdf';
    disp(['Saving frame to file: ' dataFile]);
    frame.Save(dataFile);

    disp('Disconnecting from camera');
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end