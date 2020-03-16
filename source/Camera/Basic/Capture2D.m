try
    app = zividApplication; 

    disp('Connecting to camera')
    camera = connectCamera(app);

    disp('Setting the capture settings');
    settings2D = Zivid.NET.Settings2D();
    settings2D.Iris = 22;
    settings2D.ExposureTime = Zivid.NET.Duration.FromMicroseconds(10000);
    settings2D.Gain = 1.0;

    disp('Capture a 2D frame');
    frame2D = camera.Capture2D(settings2D);

    disp('Get RGBA8 image from Frame2D');
    image = NET.invokeGenericMethod(frame2D,'Image',{'Zivid.NET.RGBA8'});

    disp(['Image Width: ',  num2str(image.Width), ' Height: ',  num2str(image.Height)]);
    disp(['Pixel (0, 0): R=', num2str(image.Item(1).r), ', G=', num2str(image.Item(1).g), ', B=', num2str(image.Item(1).b), ', A=', num2str(image.Item(1).a)]);

    byteArray = uint8(image.ToArray);
    disp(['First four bytes:  [0]: ',num2str(byteArray(1)),', [1]: ',num2str(byteArray(2)),', [2]: ',num2str(byteArray(3)),', [3]: ',num2str(byteArray(4))]);

    resultFile = 'image.png';
    disp(['Saving the image to: ' resultFile]);
    image.Save(resultFile);

    imshow(convertImageNet2Matlab(image));

catch ex

    disp(['Error: ' ex.message]);

end

function matlabImage = convertImageNet2Matlab(image)

    % matlabImage = convertImageNet2Matlab(image)
    %
    % Convert Zivid.NET.Image to matlab image
    %
    % INPUT:
    % image - Zivid.NET.Image to be converted
    %
    % OUTPUT:
    % matlabImage - image matrix (1200,1900,3)

    matlabImage = permute(reshape(uint8(image.ToArray),4,image.Width,image.Height),[3,2,1]);
    matlabImage = matlabImage(:,:,1:3);

end