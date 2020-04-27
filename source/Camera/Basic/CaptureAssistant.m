% This example shows how to use Capture Assistant to capture point clouds, with color, from the Zivid camera.

try
    zivid = zividApplication; 

    disp('Connecting to camera')
    camera = zivid.ConnectCamera;

    suggestSettingsParameters = Zivid.NET.CaptureAssistant.SuggestSettingsParameters();
    suggestSettingsParameters.AmbientLightFrequency = Zivid.NET.CaptureAssistant.('SuggestSettingsParameters+AmbientLightFrequencyOption.none');
    suggestSettingsParameters.MaxCaptureTime = Zivid.NET.Duration.FromMilliseconds(1200);

    disp('Running Capture Assistant with parameters:');
    disp(char(suggestSettingsParameters.ToString()));
    settings = Zivid.NET.CaptureAssistant.Assistant.SuggestSettings(camera, suggestSettingsParameters);

    disp('Settings suggested by Capture Assistant:');
    disp(settings.Acquisitions.ToString);
    
    disp('Manually configuring processing settings (Capture Assistant only suggests acquisition settings)')
    settings.Processing.Filters.Reflection.Removal.Enabled = true;
    settings.Processing.Filters.Smoothing.Gaussian.Enabled = true;
    settings.Processing.Filters.Smoothing.Gaussian.Sigma = 1.5;

    disp('Capturing frame');
    frame = camera.Capture(settings);

    dataFile = 'Frame.zdf';
    disp(['Saving frame to file: ' dataFile]);
    frame.Save(dataFile);

    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end