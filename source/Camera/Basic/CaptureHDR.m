try
    app = zividApplication;

    disp('Connecting to camera')
    camera = connectCamera(app);

    disp('Recording HDR source images');
    frames = NET.createGeneric('System.Collections.Generic.List',{'Zivid.NET.Frame'});

    settings = camera.Settings;
    for iris = [14 21 35]
        disp(['Capture frame with iris = ' num2str(iris)]);
        settings.Iris = iris;
        camera.SetSettings(settings)
        frames.Add(camera.Capture());
    end

    disp('Creating HDR frame');
    hdrFrame = Zivid.NET.HDR.CombineFrames(frames);

    disp('Saving the frames')
    frame(1).Save('14.zdf');
    frame(1).Save('21.zdf');
    frame(1).Save('35.zdf');
    hdrFrame.Save('HDR.zdf');

catch ex

    disp(['Error: ' ex.message]);

end