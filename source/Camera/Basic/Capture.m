try
    app = zividApplication; 

    disp('Connecting to camera')
    camera = app.ConnectCamera;

    disp('Configuring settings');
    settings = camera.Settings;
    settings.Iris = 20;
    settings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(8333);
    settings.Filters.Outlier.Enabled = true;
    settings.Filters.Outlier.Threshold = 5;
    camera.SetSettings(settings);

    disp('Capturing a frame');
    frame = camera.Capture;

    resultFile = 'Result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    frame.Save(resultFile);

    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end