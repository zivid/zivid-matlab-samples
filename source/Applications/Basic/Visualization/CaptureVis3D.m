% This example shows how to capture point clouds, with color, from the Zivid camera, and visualize it.

try
    % Adding directory that contains zividApplication to search path
    addpath(genpath([fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))),filesep,'Camera',filesep,'Basic']));

    zivid = zividApplication;

    disp('Connecting to camera');
    camera = zivid.ConnectCamera;

    disp('Configuring settings');    
    acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
    acquisitionSettings.Aperture = 5.66;
    
    settings = Zivid.NET.Settings();
    settings.Acquisitions.Add(acquisitionSettings);

    disp('Capturing a frame');
    frame = camera.Capture(settings);

    disp('Setting up visualization');
    visualizer = Zivid.NET.Visualization.Visualizer();
    
    disp('Visualizing point cloud');
    visualizer.Show(frame);
    visualizer.ShowMaximized();
    visualizer.ResetToFit();

    disp('Running visualizer. Blocking until window closes');
    disp('Note: It is not possible to run the Zivid visualizer repeatedly in Matlab. You have to restart Matlab to call the visualizer again.');
    visualizer.Run();

    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end