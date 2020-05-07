% Read the intrinsic calibration parameters of the Zivid camera (OpenCV model).

try
    % Adding directory that contains zividApplication to search path.
    addpath(genpath([fileparts(fileparts(mfilename('fullpath'))),filesep,'Camera',filesep,'Basic']));

    app = zividApplication;

    disp('Connecting to camera')
    camera = app.ConnectCamera;

    fileNameIntrinsics = 'Intrinsics.yml';
    disp(['Saving camera intrinsics to file: ', fileNameIntrinsics]);
    camera.Intrinsics.save(fileNameIntrinsics);

    disp(camera.Intrinsics.ToString());

    disp(['CX = ', num2str(camera.Intrinsics.CameraMatrix.CX)]);
    disp(['CY = ', num2str(camera.Intrinsics.CameraMatrix.CY)]);
    disp(['FX = ', num2str(camera.Intrinsics.CameraMatrix.FX)]);
    disp(['FY = ', num2str(camera.Intrinsics.CameraMatrix.FY)]);

    disp(['K1 = ', num2str(camera.Intrinsics.Distortion.K1)]);
    disp(['K2 = ', num2str(camera.Intrinsics.Distortion.K2)]);
    disp(['K3 = ', num2str(camera.Intrinsics.Distortion.K3)]);
    disp(['P1 = ', num2str(camera.Intrinsics.Distortion.P1)]);
    disp(['P2 = ', num2str(camera.Intrinsics.Distortion.P2)]);

    disp('Disconnecting from camera')
    camera.Disconnect;

catch ex

    disp(['Error: ' ex.message]);

end