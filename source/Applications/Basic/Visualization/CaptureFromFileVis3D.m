try
    % Adding directory that contains zividApplication to search path.
    addpath(genpath([fileparts(fileparts(fileparts(mfilename('fullpath')))),filesep,'Camera',filesep,'Basic']));

    app = zividApplication;

    disp('Setting up visualization');
    visualizer = Zivid.NET.CloudVisualizer();
    app.DefaultComputeDevice = visualizer.ComputeDevice;

    zdfFile = strcat(char(Zivid.NET.Environment.DataPath), '/MiscObjects.zdf');    
    disp(['Initializing camera emulation using file: ', zdfFile]);
    camera = app.CreateFileCamera(zdfFile);

    disp('Capturing a frame');
    frame = camera.Capture();

    disp('Display the frame');
    visualizer.Show(frame);
    visualizer.ShowMaximized();
    visualizer.ResetToFit();

    disp('Run the visualizer. Block until window closes');
    disp('Note: It is not possible to run the Zivid visualizer repeatedly in Matlab. You have to restart Matlab to call the visualizer again.');
    visualizer.Run();

catch ex

    disp(['Error: ' ex.message]);

end