## Introduction

This tutorial describes how to use Zivid SDK to capture point clouds and 2D images.

1. [Initialize](#initialize)
2. [Connect](#connect)
   1. [Specific Camera](#connect---specific-camera)
   2. [File Camera](#connect---file-camera)
3. [Configure](#configure)
   1. [Capture Assistant](#capture-assistant)
   2. [Manual Configuration](#manual-configuration)
      1. [Single](#single-acquisition)
      2. [Multi](#multi-acquisition-hdr)
      3. [2D](#2d-settings)
   3. [From File](#from-file)
4. [Capture](#capture)
    1. [2D](#capture-2d)
5. [Save](#save)
    1. [2D](#save-2d)
6. [Disconnect](#disconnect)

### Prerequisites

You should have installed Zivid SDK and cloned MATLAB samples. For more details see [Instructions][installation-instructions-url].

## Initialize

Before calling any of the APIs in the Zivid SDK, we have to start up the Zivid Application. This is done through a simple instantiation of the application ([go to source][start_app-url]).
```Matlab
zivid = zividApplication; 
```

## Connect

Now we can connect to the camera ([go to source][connect-url]).
```Matlab
camera = zivid.ConnectCamera;
```

### Connect - Specific Camera

Sometime multiple cameras are connected to the same computer. It might then be necessary to work with a specific camera in the code. This can be done by providing the serial number of the wanted camera.
```Matlab
camera = zivid.ConnectCamera(Zivid.NET.('CameraInfo.SerialNumber.2020C0DE'));
```

---
**Note** 

The serial number of your camera is shown in Zivid Studio.

---

You may also list all cameras connected to the computer, and view their serial numbers through
```Matlab
cameras = zivid.Cameras();
for i = 1:cameras.Count
    disp(strcat('Avaliable camera: ', char(cameras.Item(0).Info.SerialNumber())));
end
```

### Connect - File Camera

You may want to experiment with the SDK, without access to a physical camera. Minor changes are required to keep the sample working ([go to source][filecamera-url]).
```Matlab
fileCamera = [char(System.Environment.GetFolderPath(System.('Environment+SpecialFolder.CommonApplicationData'))),'/Zivid/FileCameraZividOne.zfc'];
camera = zivid.CreateFileCamera(fileCamera);
```

---
**Note**

The quality of the point cloud you get from *FileCameraZividOne.zfc* is not representative of the Zivid One+.

---

## Configure

As with all cameras there are settings that can be configured. These may be set manually, or you use our Capture Assistant.

### Capture Assistant

It can be difficult to know what settings to configure. Luckily we have the Capture Assistant. This is available in the Zivid SDK to help configure camera settings ([go to source][captureassistant-url]).
```Matlab
suggestSettingsParameters = Zivid.NET.CaptureAssistant.SuggestSettingsParameters();
suggestSettingsParameters.AmbientLightFrequency = Zivid.NET.CaptureAssistant.('SuggestSettingsParameters+AmbientLightFrequencyOption.none');
suggestSettingsParameters.MaxCaptureTime = Zivid.NET.Duration.FromMilliseconds(1200);
settings = Zivid.NET.CaptureAssistant.Assistant.SuggestSettings(camera, suggestSettingsParameters);    
```
---
**Note**

The unconventional implementation above is due to [limitations in Matlab support of .NET nested classes][nested-classes-url].

---

There are only two parameters to configure with Capture Assistant:

1. **Maximum Capture Time** in number of milliseconds.
    1. Minimum capture time is 200 ms. This allows only one acquisition.
    2. The algorithm will combine multiple acquisitions if the budget allows.
    3. The algorithm will attempt to cover as much of the dynamic range in the scene as possible.
    4. A maximum capture time of more than 1 second will get good coverage in most scenarios.
2. **Ambient light compensation**
    1. May restrict capture assistant to exposure periods that are multiples of the ambient light period.
    2. 60Hz is found in (amongst others) Japan, Americas, Taiwan, South Korea and Philippines.
    3. 50Hz is common in the rest of the world.

### Manual configuration

We may choose to configure settings manually. For more information about what each settings does, please see [Zivid One+ Camera Settings][kb-camera_settings-url].

#### Single Acquisition

We can create settings for a single capture ([go to source][settings-url]).
```Matlab
acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
acquisitionSettings.Aperture = 5.66;
acquisitionSettings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(8333);
settings = Zivid.NET.Settings();
settings.Processing.Filters.Outlier.Removal.Enabled = true;
settings.Processing.Filters.Outlier.Removal.Threshold = 5.0;
settings.Acquisitions.Add(acquisitionSettings);
```

#### Multi Acquisition HDR

We may also set a list of settings to be used in an HDR capture.
```Matlab
settings = Zivid.NET.Settings();
for aperture = [11.31,5.66,2.83]
    acquisitionSettings = Zivid.NET.('Settings+Acquisition')();
    acquisitionSettings.Aperture = aperture;
    settings.Acquisitions.Add(acquisitionSettings);
end
```

#### 2D Settings

It is possible to only capture a 2D image. This is faster than a 3D capture. 2D settings are configured as follows ([go to source][settings2d-url]).
```Matlab
acquisitionSettings = Zivid.NET.('Settings2D+Acquisition')();
acquisitionSettings.Aperture = 2.83;
acquisitionSettings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(10000);
acquisitionSettings.Gain = 1.0;
acquisitionSettings.Brightness = 1.0;
settings2D = Zivid.NET.Settings2D();
settings2D.Processing.Color.Balance.Red = 1.0;
settings2D.Processing.Color.Balance.Green = 1.0;
settings2D.Processing.Color.Balance.Blue = 1.0;
settings2D.Acquisitions.Add(acquisitionSettings);
```

### From File

Zivid Studio can store the current settings to .yml files. These can be read and applied in the API. You may find it easier to modify the settings in these (human-readable) yaml-files in your preferred editor.
```Matlab
settings = Zivid.NET.Settings('Settings.yml');
```

## Capture

Now we can capture a 3D image. Whether there is a single acquisition or multiple acquisitions (HDR) is given by the number of `acquisitions` in `settings` ([go to source][capture-url]).
```Matlab
frame = camera.Capture(settings);
```

### Capture 2D

If we only want to capture a 2D image, which is faster than 3D, we can do so via the 2D API ([go to source][capture2d-url]).
```Matlab
frame2D = camera.Capture(settings2D);
```

## Save

We can now save our results ([go to source][save-url]).
```Matlab
frame.Save('Frame.zdf');
```
The API detects which format to use. See [Point Cloud][kb-point_cloud-url] for a list of supported formats.

### Save 2D

If we captured a 2D image, we can save it ([go to source][save2d-url]).
```Matlab
frame2D.ImageRGBA().Save('Image.png');
```

## Disconnect

Finally, we can disconnect from the camera. ([go to source][disconnect-url]).
```Matlab
camera.Disconnect;
```

## Conclusion

This tutorial shows how to use the Zivid SDK to connect to, configure, capture, and save from the Zivid camera.

[//]: ### "Recommended further reading"

[installation-instructions-url]: ../../../README.md#instructions
[start_app-url]: Capture.m#L4
[connect-url]: Capture.m#L7
[settings-url]: Capture.m#L10-L17
[capture-url]: Capture.m#L20
[save-url]: Capture.m#L22-L24
[disconnect-url]: Capture.m#L27
[captureassistant-url]: CaptureAssistant.m#L9-L14
[kb-camera_settings-url]: https://support.zivid.com/latest/academy/camera/settings.html
[capture2d-url]: Capture2D.m#L24
[settings2d-url]: Capture2D.m#L10-L21
[save2d-url]: Capture2D.m#L47-49
[captureHDR-url]: CaptureAssistant.m#L10-L14
[filecamera-url]: CaptureFromFile.m#L8-L10
[kb-point_cloud-url]: https://support.zivid.com/latest/reference-articles/zivid-3d-camera-technology/point-cloud-structure-and-output-formats.html
[nested-classes-url]: https://se.mathworks.com/help/matlab/matlab_external/nested-classes.html
