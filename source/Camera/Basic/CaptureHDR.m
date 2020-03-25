try
    app = zividApplication;

    disp('Connecting to camera')
    camera = app.ConnectCamera;

    disp('Recording HDR source images');
    frames = NET.createGeneric('System.Collections.Generic.List',{'Zivid.NET.Frame'});

    settings = camera.Settings;
    for iris = [14 21 35]
        disp(['Capturing frame with iris = ' num2str(iris)]);
        settings.Iris = iris;
        camera.SetSettings(settings)
        frames.Add(camera.Capture());
    end

    disp('Creating HDR frame');
    hdrFrame = Zivid.NET.HDR.CombineFrames(frames);

    disp('Saving framese to file:');
    frames.Item(0).Save('14.zdf');
    frames.Item(1).Save('21.zdf');
    frames.Item(2).Save('35.zdf');
    hdrFrame.Save('HDR.zdf');
    
    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end