try
    app = zividApplication;

    zdfFile = strcat(char(Zivid.NET.Environment.DataPath), '/MiscObjects.zdf');    
    disp(['Initializing camera emulation using file: ', zdfFile]);
    camera = app.CreateFileCamera(zdfFile);

    disp('Capture a frame');
    frame = camera.Capture();

    resultFile = 'result.zdf';
    disp(['Saving frame to file: ', resultFile]);    
	frame.Save(resultFile);

catch ex

    disp(['Error: ' ex.message]);

end