try
    app = zividApplication; 

    disp('Connecting to camera')
    camera = connectCamera(app);

    disp('Adjusting the camera settings');
    settings = camera.Settings;
    settings.Iris = 20;
    settings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(8333);
    settings.Filters.Outlier.Enabled = true;
    settings.Filters.Outlier.Threshold = 5;
    camera.SetSettings(settings);

    disp('Capture a frame');
    frame = camera.Capture;

    resultFile = 'result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    frame.Save(resultFile);

catch ex

    disp(['Error: ' ex.message]);

end