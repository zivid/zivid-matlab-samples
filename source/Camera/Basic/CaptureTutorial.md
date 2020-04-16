## Introduction

This tutorial describes how to use Zivid SDK to capture point clouds and 2D images.

1. [Initialize](#initialize)
2. [Connect](#connect)
   1. [Specific Camera](#connect---specific-camera)
   2. [Virtual Camera](#connect---virtual-camera)
3. [Configure](#configure)
   1. [Capture Assistant](#capture-assistant)
   2. [Manual Configuration](#manual-configuration)
      1. [Single](#single-frame)
      2. [HDR](#hdr-frame)
      3. [2D](#2d-settings)
   3. [From File](#from-file)
4. [Capture](#capture)
    1. [HDR](#capture-hdr)
    2. [2D](#capture-2d)
5. [Save](#save)
    1. [2D](#save-2d)
6. [Disconnect](#disconnect)

### Prerequisites

You should have installed Zivid SDK. For more details see [Instructions][installation-instructions-url].

## Initialize

Before calling any of the APIs in the Zivid SDK, we have to start up the Zivid Application. This is done through a simple instantiation of the application ([go to source][start_app-url]).
```Matlab
app = zividApplication; 
```

## Connect

Now we can connect to the camera ([go to source][connect-url]).
```Matlab
camera = app.ConnectCamera;
```

### Connect - Specific Camera

Sometime multiple cameras are connected to the same computer. It might then be necessary to work with a specific camera in the code. This can be done by providing the serial number of the wanted camera.
```Matlab
camera = app.ConnectCamera(Zivid.NET.SerialNumber("2020C0DE"));
```

---
**Note** 

The serial number of your camera is shown in the Zivid Studio.

---

You may also list all cameras connected to the computer, and view their serial numbers through
```Matlab
cameras = app.Cameras();
for i = 1:cameras.Count
    disp(strcat('Avaliable camera: ', char(cameras.Item(0).SerialNumber().ToString())))
end
```

### Connect - Virtual Camera

You may want to experiment with the SDK, without access to a physical camera. Minor changes are required to keep the sample working ([go to source][filecamera-url]).
```Matlab
zdfFile = strcat(char(Zivid.NET.Environment.DataPath), '/MiscObjects.zdf');    
camera = app.CreateFileCamera(zdfFile);
```

---
**Note**

The quality of the point cloud you get from *MiscObjects.zdf* is not representative of the Zivid One+.

---

## Configure

As with all cameras there are settings that can be configured. These may be set manually, or you use our Capture Assistant.

### Capture Assistant

It can be difficult to know what settings to configure. Luckily we have the Capture Assistant. This is available in the Zivid SDK to help configure camera settings ([go to source][captureassistant-url]).
```Matlab
suggestSettingsParameters = Zivid.NET.('CaptureAssistant+SuggestSettingsParameters')(Zivid.NET.Duration.FromMilliseconds(1200),Zivid.NET.('CaptureAssistant+AmbientLightFrequency.none'));
    disp(['Running Capture Assistant with parameters: ', char(suggestSettingsParameters.ToString())]);
    settingsList = Zivid.NET.CaptureAssistant.SuggestSettings(camera, suggestSettingsParameters);
```
---
**Note**

The unconventional implmentation above is due to [limitations in Matlab support of .NET nested classes][nested-classes-url].

---

These settings can be used in an [HDR capture](#capture-hdr), which we will discuss later.

As opposed to manual configuration of settings, there are only two parameters to consider with Capture Assistant.

1. **Maximum Capture Time** in number of milliseconds.
    1. Minimum capture time is 200ms. This allows only one frame to be captured.
    2. The algorithm will combine multiple frames if the budget allows.
    3. The algorithm will attempt to cover as much of the dynamic range in the scene as possible.
    4. A maximum capture time of more than 1 second will get good coverage in most scenarios.
2. **Ambient light compensation**
    1. May restrict capture assistant to exposure periods that are multiples of the ambient light period.
    2. 60Hz is found in (amongst others) Japan, Americas, Taiwan, South Korea and Philippines.
    3. 50Hz is found in most rest of the world.

### Manual configuration

We may choose to configure settings manually. For more information about what each settings does, please see [Zivid One+ Camera Settings][kb-camera_settings-url].

#### Single Frame

We can configure settings for an individual frame directly to the camera ([go to source][settings-url]).
```Matlab
settings = camera.Settings;
settings.Iris = 20;
settings.ExposureTime = Zivid.NET.Duration.FromMicroseconds(8333);
settings.Brightness = 1;
settings.Gain = 1;
settings.Bidirectional = false;
settings.Filters.Contrast.Enabled = true;
settings.Filters.Contrast.Threshold = 5;
settings.Filters.Gaussian.Enabled = true;
settings.Filters.Gaussian.Sigma = 1.5;
settings.Filters.Outlier.Enabled = true;
settings.Filters.Outlier.Threshold = 5;
settings.Filters.Reflection.Enabled = true;
settings.Filters.Saturated.Enabled = true;
settings.BlueBalance = 1.081;
settings.RedBalance = 1.709;
camera.SetSettings(settings);
```

#### HDR Frame

We may also set a list of settings to be used in an HDR capture.
```Matlab
iris = [14 21 35];
settingsList = NET.createArray('Zivid.NET.Settings',length(iris));
    for i = 1:length(iris)
    settings = Zivid.NET.Settings;
    settings.Iris = iris(i);
    settingsList(i) = settings;
end
```

#### 2D Settings

It is possible to only capture a 2D image. This is faster than a 3D capture, and can be used . 2D settings are configured as follows ([go to source][settings2d-url]).
```Matlab
settings2D = Zivid.NET.Settings2D();
settings2D.Iris = 35;
settings2D.ExposureTime = Zivid.NET.Duration.FromMicroseconds(10000);
settings2D.Gain = 1.0;
settings2D.Brightness = 1.0
```

### From File

Zivid Studio can store the current settings to .yml files. These can be read and applied in the API. You may find it easier to modify the settings in these (human-readable) yaml-files in your preferred editor.
```Matlab
camera.SetSettings(Zivid.NET.Settings("frame_01.yml"));
```

## Capture

Now we can capture a frame. The default capture is a single 3D point cloud ([go to source][capture-url]).
```Matlab
frame = camera.Capture();
```

### Capture HDR

As was revealed in the [Capture Assistant](#capture-assistant) section, a capture may consist of multiple frames. In order to capture multiple frames, and combine them, we can do as follows ([go to source][captureHDR-url])
```Matlab
hdrFrame = Zivid.NET.HDR.Capture(camera, settingsList);
```
It is possible to [manually create](#hdr-frame) the `settingsList`, if not set via [Capture Assistant](#capture-assistant).

### Capture 2D

If we only want to capture a 2D image, which is faster than 3D, we can do so via the 2D API ([go to source][capture2d-url]).
```Matlab
frame2D = camera.Capture2D(settings2D);
image2D = NET.invokeGenericMethod(frame2D,'Image',{'Zivid.NET.RGBA8'})
```

## Save

We can now save our results ([go to source][save-url]).
```Matlab
frame.Save('result.zdf');
```
The API detects which format to use. See [Point Cloud][kb-point_cloud-url] for a list of supported formats.

### Save 2D

If we captured a 2D image, we can save it ([go to source][save2d-url]).
```Matlab
image2D.Save('result.png');
```

## Disconnect

Finally, we can disconnect from the camera. ([go to source][disconnect-url]).
```Matlab
camera.Disconnect;
```

## Conclusion

This tutorial shows how to use the Zivid SDK to connect to, configure and capture from the Zivid camera.

[//]: ### "Recommended further reading"

[installation-instructions-url]: ../../../README.md#instructions
[start_app-url]: Capture.m#L2
[connect-url]: Capture.m#L5
[captureassistant-url]: CaptureAssistant.m#L7-L9
[settings-url]: Capture.m#L8-L13
[kb-camera_settings-url]: https://zivid.atlassian.net/wiki/spaces/ZividKB/pages/99713044/Zivid+One+Camera+Settings
[capture-url]: Capture.m#L16
[capture2d-url]: Capture2D.m#L14-L17
[settings2d-url]: Capture2D.m#L8-L11
[captureHDR-url]: CaptureAssistant.m#L9-L19
[save-url]: Capture.m#L18-L20
[save2d-url]: Capture2D.m#L25-L27
[disconnect-url]: Capture.m#L23
[kb-point_cloud-url]: https://zivid.atlassian.net/wiki/spaces/ZividKB/pages/427396/Point+Cloud
[filecamera-url]: CaptureFromFile.m#L4-L6
[nested-classes-url]: https://se.mathworks.com/help/matlab/matlab_external/nested-classes.html
