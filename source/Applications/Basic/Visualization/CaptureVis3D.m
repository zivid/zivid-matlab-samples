try
    % Adding directory that contains zividApplication to search path.
    addpath(genpath([fileparts(fileparts(fileparts(mfilename('fullpath')))),filesep,'Camera',filesep,'Basic']));

    app = zividApplication;

    disp('Setting up visualization');
    visualizer = Zivid.NET.CloudVisualizer();
    app.DefaultComputeDevice = visualizer.ComputeDevice;

    disp('Connecting to camera')
    camera = app.ConnectCamera;

    disp('Configuring settings');
    settings = camera.Settings;
    settings.Iris = 20;
    camera.SetSettings(settings);

    disp('Capturing a frame');
    frame = camera.Capture;

    resultFile = 'result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    frame.Save(resultFile);

    disp('Display the frame');
    visualizer.Show(frame);
    visualizer.ShowMaximized();
    visualizer.ResetToFit();

    disp('Run the visualizer. Block until window closes');
    disp('Note: It is not possible to run the Zivid visualizer repeatedly in Matlab. You have to restart Matlab to call the visualizer again.');
    visualizer.Run();

    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end