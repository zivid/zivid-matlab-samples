% Read intrinsic parameters from the Zivid camera (OpenCV model).

% Note: This example uses experimental SDK features, which may be modified, moved, or deleted in the future without notice.

try
    % Adding directory that contains zividApplication to search path.
    addpath(genpath([fileparts(fileparts(fileparts(mfilename('fullpath')))),filesep,'Camera',filesep,'Basic']));

    zivid = zividApplication;

    disp('Connecting to camera');
    camera = zivid.ConnectCamera;

    disp('Getting camera intrinsics');
    intrinsics = Zivid.NET.Experimental.Calibration.Calibrator.Intrinsics(camera);

    disp(intrinsics.ToString);

    disp('Separated camera intrinsic parameters:');

    disp(['CX = ',num2str(intrinsics.CameraMatrix.CX)]);
    disp(['CY = ',num2str(intrinsics.CameraMatrix.CY)]);
    disp(['FX = ',num2str(intrinsics.CameraMatrix.FX)]);
    disp(['FY = ',num2str(intrinsics.CameraMatrix.FY)]);

    disp(['K1 = ',num2str(intrinsics.Distortion.K1)]);
    disp(['K2 = ',num2str(intrinsics.Distortion.K2)]);
    disp(['K3 = ',num2str(intrinsics.Distortion.K3)]);
    disp(['P1 = ',num2str(intrinsics.Distortion.P1)]);
    disp(['P2 = ',num2str(intrinsics.Distortion.P2)]);

    intrinsicsFile = 'Intrinsics.yml';
    disp(['Saving camera intrinsics to file: ',intrinsicsFile]);
    intrinsics.Save(intrinsicsFile);

    disp('Disconnecting from camera');
    camera.Disconnect;

catch ex

    throw(ex)

end
