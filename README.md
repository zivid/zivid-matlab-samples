# matlab-samples

This repository contains **MATLAB** code samples for **Zivid**.

![Zivid Image][header-image]

---

*Contents:*
[**Samples**](#Samples-list) |
[**Instructions**](#Instructions) |
[**Support**](#Support) |
[**Licence**](#Licence)

---


## Samples list

There are two main categories of samples: **Camera** and **Applications**. The samples in the **Camera** category focus only on how to use the camera. The samples in the **Applications** category use the output generated by the camera, such as the 3D point cloud, a 2D image or other data from the camera. These samples shows how the data from the camera can be used.

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

Note: The sample scripts require [**Image Processing Toolbox**](https://se.mathworks.com/products/image.html) and [**Computer Vision Toolbox**](https://se.mathworks.com/products/computer-vision.html).

## Instructions

1. [**Install Zivid Software**](https://www.zivid.com/downloads).
Note: The samples require Zivid SDK v2 (minor version 2.1 or newer).

3. [**Download Zivid Sample Data**](https://zivid.atlassian.net/wiki/spaces/ZividKB/pages/450363393/Sample+Data).

4. [**Install MATLAB Software**](https://se.mathworks.com/products/matlab.html).
Note: The version tested with Zivid cameras is 2019a.

5. Launch MATLAB.

6. Open and run one of the samples.

## Support
If you need assistance with using Zivid cameras, visit our Knowledge Base at [help.zivid.com](https://help.zivid.com/) or contact us at [customersuccess@zivid.com](mailto:customersuccess@zivid.com).

## Licence
Zivid Samples are distributed under the [BSD license](https://github.com/zivid/matlab-samples/blob/master/LICENSE).

[header-image]: https://www.zivid.com/hubfs/softwarefiles/images/zivid-generic-github-header.png
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
