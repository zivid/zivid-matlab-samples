function application = zividApplication(folder)

    % application = zividApplication(folder)
    %
    % Create Zivid Application
    %
    % INPUT:
    % folder - path to Zivid\bin folder, default: C:\Program Files\Zivid\bin
    %
    % OUTPUT:
    % application - Zivid Application

    if nargin < 1
        folder = [getenv('ZIVID_INSTALL_FOLDER'),'\bin'];
    end

    global ZIVID_APPLICATION

    if isempty(ZIVID_APPLICATION)
        addpath(folder);
        NET.addAssembly([folder,'\ZividCoreNET.dll']);
        NET.addAssembly([folder,'\ZividVisualizationNET.dll']);
        import Zivid.*;
        import Zivid.NET.CaptureAssistant.*;
        import Zivid.NET.HandEye.*;
        ZIVID_APPLICATION = Zivid.NET.Application;
    end

    application = ZIVID_APPLICATION;

end
