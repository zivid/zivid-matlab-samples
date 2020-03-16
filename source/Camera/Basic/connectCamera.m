function camera = connectCamera(application,folder)

    % Camera = connectCamera(application)
    %
    % Connect to Zivid Camera
    %
    % INPUT:
    % application - Zivid Application
    % folder - path to Zivid\bin folder, default: C:\Program Files\Zivid\bin
    %
    % OUTPUT:
    % camera - Zivid Camera

    global ZIVID_CAMERA

    if isempty(ZIVID_CAMERA)

        if nargin < 1
            application = [];
        end

        if nargin < 2
            if isempty(which('ZividNET.dll'))
                folder = 'C:\Program Files\Zivid\bin';
            else
                folder = which('ZividNET.dll');
                folder = folder(1:end-13);
            end
        end

        if isempty(application)
            application = ZividNETinitialize(folder);
        end

        current = cd;

        cd(folder)
        goback = onCleanup(@() cd(current));

        ZIVID_CAMERA = application.ConnectCamera;

    end

    camera = ZIVID_CAMERA;

end
