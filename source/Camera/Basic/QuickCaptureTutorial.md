## Introduction

This tutorial shows how few API calls are required to capture a point cloud with Zivid SDK.

1. [Connect](#connect)
2. [Configure](#configure)
3. [Capture](#capture)
4. [Save](#save)
5. [Disconnect](#disconnect)

### Prerequisites

You should have installed Zivid SDK and cloned MATLAB samples. For more details see [Instructions][installation-instructions-url].

Before calling any of the APIs in the Zivid SDK, we have to start up the Zivid Application. This is done through a simple instantiation of the application ([go to source][start_app-url]).
```Matlab
zivid = zividApplication; 
```

## Connect

First we have to connect to the camera ([go to source][connect-url]).
```Matlab
camera = zivid.ConnectCamera;
```

## Configure

Then we have to create settings ([go to source][settings-url]).
```Matlab
settings = Zivid.NET.Settings();
acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
settings.Acquisitions.Add(acquisitionSettings)
```

## Capture

Now we can capture a frame. The default capture is a single 3D point cloud ([go to source][capture-url]).
```Matlab
frame = camera.Capture(settings);
```

## Save

We can now save our results. By default the 3D point cloud is saved in Zivid format `.zdf` ([go to source][save-url]).
```Matlab
frame.Save("Frame.zdf");
```

## Disconnect

Finally, we can disconnect from the camera. ([go to source][disconnect-url]).
```Matlab
camera.Disconnect;
```

## Conclusion

This tutorial showed how few API calls are required to capture a point cloud with Zivid SDK.

### Recommended further reading

[The complete Capture Tutorial](CaptureTutorial.md)

[installation-instructions-url]: ../../../README.md#instructions
[start_app-url]: Capture.m#L4
[connect-url]: Capture.m#L7
[settings-url]: Capture.m#L10-L17
[capture-url]: Capture.m#L20
[save-url]: Capture.m#L22-L24
[disconnect-url]: Capture.m#L27
