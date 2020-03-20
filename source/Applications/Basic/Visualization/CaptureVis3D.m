try
    % Adding directory that contains zividApplication and connectCamera to search path.
    addpath(genpath([fileparts(fileparts(fileparts(pwd))),filesep,'Camera',filesep,'Basic']));

    app = zividApplication;

    disp('Setting up visualization');
    visualizer = Zivid.NET.CloudVisualizer();
    app.DefaultComputeDevice = visualizer.ComputeDevice;

    disp('Connecting to camera')
    camera = connectCamera(app);

    disp('Adjusting the iris');
    settings = camera.Settings;
    settings.Iris = 20;
    camera.SetSettings(settings);

    disp('Capture a frame');
    frame = camera.Capture;

    resultFile = 'result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    frame.Save(resultFile);

    disp('Display the frame');
    visualizer.Show(frame);
    visualizer.ShowMaximized();
    visualizer.ResetToFit();

    disp('Run the visualizer. Block until window closes');
    visualizer.Run();

catch ex

    disp(['Error: ' ex.message]);

end