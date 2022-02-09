# MATLAB samples

This repository contains MATLAB code samples for Zivid SDK v2.6.1. For
tested compatibility with earlier SDK versions, please check out
[accompanying
releases](https://github.com/zivid/zivid-matlab-samples/tree/master/../../releases).

![image](https://www.zivid.com/hubfs/softwarefiles/images/zivid-generic-github-header.png)



---

*Contents:*
[**Samples**](#Samples-list) |
[**Installation**](#Installation) |
[**Support**](#Support) |
[**License**](#License)

---



## Samples list

There are two main categories of samples: **Camera** and
**Applications**. The samples in the **Camera** category focus only on
how to use the camera. The samples in the **Applications** category use
the output generated by the camera, such as the 3D point cloud, a 2D
image or other data from the camera. These samples shows how the data
from the camera can be used.

- **Camera**
  - **Basic** ([quick tutorial][QuickCaptureTutorial-url] / [complete tutorial][CompleteCaptureTutorial-url])
    - [**Capture**][Capture-url] - Capture point clouds, with color, from the Zivid camera.
    - [**Capture2D**][Capture2D-url] - Capture 2D images from the Zivid camera.
    - [**CaptureAssistant**][CaptureAssistant-url] - Use Capture Assistant to capture point clouds, with color, from the Zivid camera.
    - [**CaptureFromFileCamera**][CaptureFromFileCamera-url] - Capture point clouds, with color, from the Zivid file camera.
    - [**CaptureHDR**][CaptureHDR-url] - Capture HDR point clouds, with color, from the Zivid camera.
    - [**zividApplication**][zividApplication-url] - Initialize Zivid.
  - **InfoUtilOther**
    - [**GetCameraIntrinsics**][GetCameraIntrinsics-url] - Read intrinsic parameters from the Zivid camera.

- **Applications**
  - **Basic**
    - **Visualization**
      - [**CaptureFromFileCameraVis3D**][CaptureFromFileCameraVis3D-url] - Capture point clouds, with color, from the Zivid file camera, and visualize it.
      - [**CaptureVis3D**][CaptureVis3D-url] - Capture point clouds, with color, from the Zivid camera, and visualize it.
    - **FileFormats**
      - [**readZDF**][readZDF-url] - Read point cloud data from ZDF file.
      - [**ReadIterateZDF**][ReadIterateZDF-url] - Read point cloud data from a ZDF file, iterate through it, and extract individual points.
      - [**convertZDF**][convertZDF-url] - Convert from ZDF to your preferred format (PLY, CSV, TXT, PNG, JPG, BMP, TIFF).
  - **Advanced**
    - [**Downsample**][Downsample-url]  - Downsample point cloud from ZDF file.

Note: The sample scripts require [**Image Processing Toolbox**][image-processing-toolbox-url] and [**Computer Vision Toolbox**][computer-vision-toolbox-url].

## Installation

1.  [Install Zivid
    Software](https://support.zivid.com/latest//getting-started/software-installation.html)
Note: The samples require Zivid SDK v2 (minor version 2.1 or newer).
2.  [Download Zivid Sample
    Data](https://support.zivid.com/latest//api-reference/samples/sample-data.html)
3.  [Install MATLAB
    Software](https://se.mathworks.com/products/matlab.html). Note: The
    version tested with Zivid cameras is 2019a.

See [Create a MATLAB "Hello World" Application With Reference to Zivid
.NET
API](https://support.zivid.com/latest/rst/api-reference/samples/matlab/create-a-matlab-hello-world-application-with-reference-to-zivid-dot-net-sdk.html)

## Support

For more information about the Zivid cameras, please visit our
[Knowledge Base](https://support.zivid.com/latest). If you run into any
issues please check out
[Troubleshooting](https://support.zivid.com/latest/rst/support/troubleshooting.html).

## License

Zivid Samples are distributed under the [BSD
license](https://github.com/zivid/zivid-matlab-samples/tree/master/LICENSE).

[QuickCaptureTutorial-url]: source/Camera/Basic/QuickCaptureTutorial.md
[CompleteCaptureTutorial-url]: source/Camera/Basic/CaptureTutorial.md
[Capture-url]: source/Camera/Basic/Capture.m
[Capture2D-url]: source/Camera/Basic/Capture2D.m
[CaptureAssistant-url]: source/Camera/Basic/CaptureAssistant.m
[CaptureFromFileCamera-url]: source/Camera/Basic/CaptureFromFileCamera.m
[CaptureHDR-url]: source/Camera/Basic/CaptureHDR.m
[zividApplication-url]: source/Camera/Basic/zividApplication.m
[GetCameraIntrinsics-url]: source/Camera/InfoUtilOther/GetCameraIntrinsics.m

[CaptureFromFileCameraVis3D-url]: source/Applications/Basic/Visualization/CaptureFromFileCameraVis3D.m
[CaptureVis3D-url]: source/Applications/Basic/Visualization/CaptureVis3D.m
[readZDF-url]: source/Applications/Basic/FileFormats/readZDF.m
[ReadIterateZDF-url]: source/Applications/Basic/FileFormats/ReadIterateZDF.m
[convertZDF-url]: source/Applications/Basic/FileFormats/convertZDF.m
[Downsample-url]: source/Applications/Advanced/Downsample.m

[matlab-url]: https://se.mathworks.com/products/matlab.html
[image-processing-toolbox-url]: https://se.mathworks.com/products/image.html
[computer-vision-toolbox-url]: https://se.mathworks.com/products/computer-vision.html
