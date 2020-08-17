% This example shows how to capture 2D images from the Zivid camera.

try
    zivid = zividApplication;

    disp('Connecting to camera');
    camera = zivid.ConnectCamera;

    disp('Configuring 2D settings');
    acquisitionSettings = Zivid.NET.('Settings2D+Acquisition')();
    acquisitionSettings.Aperture = 11.31;
    acquisitionSettings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(30000);
    acquisitionSettings.Gain = 2.0;
    acquisitionSettings.Brightness = 1.80;
    

    settings2D = Zivid.NET.Settings2D();
    settings2D.Processing.Color.Balance.Red = 1.0;
    settings2D.Processing.Color.Balance.Green = 1.0;
    settings2D.Processing.Color.Balance.Blue = 1.0;
    settings2D.Acquisitions.Add(acquisitionSettings);

    disp('Capturing 2D frame');
    frame2D = camera.Capture(settings2D);
 
    disp('Getting RGBA image');
    image = frame2D.ImageRGBA();

    pixelRow = 100;
    pixelCol = 50;

    disp('Extracting 2D pixel array');
    pixelArray = image.ToArray();
    disp(['Width: ',num2str(pixelArray.GetLength(0)),', Height: ',num2str(pixelArray.GetLength(1))]);
    disp(['Color at pixel (',num2str(pixelRow),',',num2str(pixelCol),'):  R:',num2str(pixelArray.GetValue(0,0).r),'  G:',num2str(pixelArray.GetValue(0,0).g),'  B:',num2str(pixelArray.GetValue(0,0).b),'  A:',num2str(pixelArray.GetValue(0,0).a)]);
 
    disp('Extracting 3D array of bytes');
    nativeArray = image.ToByteArray();
    disp(['Height: ' num2str(nativeArray.GetLength(0)),', Width: ',num2str(nativeArray.GetLength(1)),', Channels: ',num2str(nativeArray.GetLength(2))]);
    disp(['Color at pixel (',num2str(pixelRow),',',num2str(pixelCol),'):  R:',num2str(nativeArray.GetValue(0,0,0)),'  G:',num2str(nativeArray.GetValue(0,0,1)),',  B:',num2str(nativeArray.GetValue(0,0,2)),',  A:',num2str(nativeArray.GetValue(0,0,3))]);
 
    disp('Extracting 3D Matlab array');
    matlabArray = uint8(nativeArray);
    disp(['Height: ' num2str(size(matlabArray,1)),', Image Width: ',num2str(size(matlabArray,2)),', Channels: ',num2str(size(matlabArray,3))]);
    disp(['Color at pixel (',num2str(pixelRow),',',num2str(pixelCol),'):  R:',num2str(matlabArray(1,1,1)),',  G:',num2str(matlabArray(1,1,2)),',  B:',num2str(matlabArray(1,1,3)),',  A:',num2str(matlabArray(1,1,4))]);
 
    imageFile = 'Image.png';
    disp(['Saving image to file: ',imageFile]);
    image.Save(imageFile);

    disp('Visualizing image');
    imshow(matlabArray(:,:,1:3));

    disp('Disconnecting from camera');
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end