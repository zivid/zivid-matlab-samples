try
    app = zividApplication; 

    disp('Connecting to camera')
    camera = connectCamera(app);
    
    suggestSettingsParameters = Zivid.NET.('CaptureAssistant+SuggestSettingsParameters')(Zivid.NET.Duration.FromMilliseconds(1200),Zivid.NET.('CaptureAssistant+AmbientLightFrequency.none'));
    disp(['Running Capture Assistant with parameters: ', char(suggestSettingsParameters.ToString())]);
    settingsList = Zivid.NET.CaptureAssistant.SuggestSettings(camera, suggestSettingsParameters);
    
    disp('Suggested settings are:');
    for i = 0:settingsList.Count-1
        displaySettings(settingsList.Item(i));
    end
    
    disp('Capture (and merge) frames using automatically suggested settings');
    hdrFrame = Zivid.NET.HDR.Capture(camera, settingsList);
    
    resultFile = 'result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    hdrFrame.Save(resultFile);

catch ex

    disp(['Error: ' ex.message]);
    
end

function displaySettings(settings)
    
    % displaySettings(settings)
    %
    % Display Zivid settings
    %
    % INPUT:
    % settings - Zivid settings
    
    disp('Settings:')
    disp(['  Bidirectional: ' ,logical2yesno(settings.Bidirectional)]);
    disp(['  BlueBalance: ' ,num2str(settings.BlueBalance)]);
    disp(['  Brightness: ' ,num2str(settings.Brightness)]);
    disp(['  ExposureTime: ' ,num2str(settings.ExposureTime.Microseconds)]);
    disp('  Filters:');
    disp('    Contrast:');
    disp(['      Enabled: ' ,logical2yesno(settings.Filters.Contrast.Enabled)]);
    disp(['      Threshold: ' ,num2str(settings.Filters.Contrast.Threshold)]);
    disp('    Gaussian:');
    disp(['      Enabled: ' ,logical2yesno(settings.Filters.Gaussian.Enabled)]);
    disp(['      Sigma: ' ,num2str(settings.Filters.Gaussian.Sigma)]);
    disp('    Outlier:');
    disp(['      Enabled: ' ,logical2yesno(settings.Filters.Outlier.Enabled)]);
    disp(['      Threshold: ' ,num2str(settings.Filters.Outlier.Threshold)]);
    disp('    Reflection:');
    disp(['      Enabled: ' ,logical2yesno(settings.Filters.Reflection.Enabled)]);
    disp('    Saturated:');
    disp(['      Enabled: ' ,logical2yesno(settings.Filters.Saturated.Enabled)]);
    disp(['  Gain: ' ,num2str(settings.Gain)]);
    disp(['  Iris: ' ,num2str(settings.Iris)]);
    disp(['  RedBalance: ' ,num2str(settings.RedBalance)]);
    
end

function logicalString = logical2yesno(logical)
    
    % logicalString = logical2yesno(logicalValue)
    %
    % Convert logical value (1 and 0) to string ('yes' and 'no') 
    %
    % INPUT:
    % logical - logical value (1 or 0)
    %
    % OUTPUT:
    % logicalString - string ('yes' or 'no')
    %

    if logical
        logicalString = 'yes';
    else
        logicalString = 'no';
    end

end