try
    app = zividApplication; 

    disp('Connecting to camera')
    camera = connectCamera(app);
    
    suggestSettingsParameters = Zivid.NET.('CaptureAssistant+SuggestSettingsParameters')(Zivid.NET.Duration.FromMilliseconds(1200),Zivid.NET.('CaptureAssistant+AmbientLightFrequency.none'));
    disp(['Running Capture Assistant with parameters: ', char(suggestSettingsParameters.ToString())]);
    settingsList = Zivid.NET.CaptureAssistant.SuggestSettings(camera, suggestSettingsParameters);
    
    disp('Suggested settings are:');
    for i = 0:settingsList.Count-1
        disp(settingsList.Item(i).ToString);
    end
    
    disp('Capture (and merge) frames using automatically suggested settings');
    hdrFrame = Zivid.NET.HDR.Capture(camera, settingsList);
    
    resultFile = 'result.zdf';
    disp(['Saving frame to file: ' resultFile]);
    hdrFrame.Save(resultFile);

catch ex

    disp(['Error: ' ex.message]);
    
end