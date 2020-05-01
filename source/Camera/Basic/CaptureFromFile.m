try
    app = zividApplication;

    zdfFile = strcat(char(Zivid.NET.Environment.DataPath), '/MiscObjects.zdf');    
    disp(['Initializing camera emulation using file: ', zdfFile]);
    camera = app.CreateFileCamera(zdfFile);

    disp('Capturing a frame');
    frame = camera.Capture();

    resultFile = 'Result.zdf';
    disp(['Saving frame to file: ', resultFile]);
    frame.Save(resultFile);

catch ex

    disp(['Error: ' ex.message]);

end