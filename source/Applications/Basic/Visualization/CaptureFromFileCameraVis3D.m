% This example shows how to capture point clouds, with color, from the Zivid file camera,
% and visualize it. This example can be used without access to a physical camera.

try
    % Adding directory that contains zividApplication to search path
    addpath(genpath([fileparts(fileparts(fileparts(fileparts(mfilename('fullpath'))))),filesep,'Camera',filesep,'Basic']));

    zivid = zividApplication;

    % This FileCamera file is in Zivid Sample Data. See instructions in README.md
    fileCamera = [char(System.Environment.GetFolderPath(System.('Environment+SpecialFolder.CommonApplicationData'))),'/Zivid/FileCameraZividOne.zfc'];
    disp(['Creating virtual camera using file: ',fileCamera]);
    camera = zivid.CreateFileCamera(fileCamera);

    disp('Configuring settings');
    settings = Zivid.NET.Settings();
    settings.Processing.Filters.Smoothing.Gaussian.Enabled = true;
    settings.Processing.Filters.Smoothing.Gaussian.Sigma = 1.5;
    settings.Processing.Filters.Reflection.Removal.Enabled = 1.5;
    settings.Processing.Color.Balance.Red = 1.0;
    settings.Processing.Color.Balance.Green = 1.0;
    settings.Processing.Color.Balance.Blue = 1.0;
    acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
    settings.Acquisitions.Add(acquisitionSettings);
    
    settings = Zivid.NET.Settings();
    settings.Acquisitions.Add(acquisitionSettings);

    disp('Capturing frame');
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

catch ex

    disp(['Error: ' ex.message]);

end