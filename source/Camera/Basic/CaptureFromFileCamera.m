% Capture point clouds, with color, from the Zivid file camera. Currently supported by Zivid One.

% This example can be used without access to a physical camera.
% The ZFC files for this sample can be found under the main instructions for Zivid samples.

try
    zivid = zividApplication;

    % This FileCamera file is in Zivid Sample Data. See instructions in README.md.
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

    disp('Capturing frame');
    frame = camera.Capture(settings);

    dataFile = 'Frame.zdf';
    disp(['Saving frame to file: ',dataFile]);
    frame.Save(dataFile);

catch ex

    throw(ex)

end
