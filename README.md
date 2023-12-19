# MATLAB samples

This repository contains matlab code samples for Zivid SDK v2.11.0. For
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
      - **Basic**
          - [Capture](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/Capture.m) - Capture point clouds, with color, from the Zivid camera.
          - [Capture2D](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/Capture2D.m) - Capture 2D images from the Zivid camera.
          - [CaptureAssistant](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/CaptureAssistant.m) - Capture Assistant to capture point clouds, with color,
            from the Zivid camera.
          - [CaptureFromFileCamera](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/CaptureFromFileCamera.m) - Capture point clouds, with color, from the Zivid file
            camera. Currently supported by Zivid One.
          - [CaptureHDR](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/CaptureHDR.m) - Capture HDR point clouds, with color, from the Zivid
            camera.
          - [zividApplication](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/Basic/zividApplication.m) - application = zividApplication(folder)
      - **InfoUtilOther**
          - [GetCameraIntrinsics](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Camera/InfoUtilOther/GetCameraIntrinsics.m) - Read intrinsic parameters from the Zivid camera (OpenCV
            model).
  - **Applications**
      - **Basic**
          - **Visualization**
              - [CaptureFromFileCameraVis3D](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Basic/Visualization/CaptureFromFileCameraVis3D.m) - Capture point clouds, with color, from the virtual
                Zivid camera, and visualize it. Currently supported by
                Zivid One.
              - [CaptureVis3D](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Basic/Visualization/CaptureVis3D.m) - Capture point clouds, with color, from the Zivid
                camera, and visualize it.
          - **FileFormats**
              - [convertZDF](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Basic/FileFormats/convertZDF.m) - convertZDF(inputFileName,outputFileFormat)
              - [ReadIterateZDF](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Basic/FileFormats/ReadIterateZDF.m) - Read point cloud data from a ZDF file, iterate through
                it, and extract individual points.
              - [readZDF](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Basic/FileFormats/readZDF.m) - \[xyz,rgba,snr\] = readZDF(dataFile) - **Advanced**
          - [Downsample](https://github.com/zivid/zivid-matlab-samples/tree/master/source/Applications/Advanced/Downsample.m) - Downsample point cloud from ZDF file.

## Installation

1.  [Install Zivid
    Software](https://support.zivid.com/latest//getting-started/software-installation.html)
2.  [Download Zivid Sample
    Data](https://support.zivid.com/latest//api-reference/samples/sample-data.html)
3.  [Install MATLAB
    Software](https://se.mathworks.com/products/matlab.html). Note: The
    version tested with Zivid cameras is 2019a.

See [Create a MATLAB "Hello World" Application With Reference to Zivid
.NET
API](https://support.zivid.com/latest/api-reference/samples/matlab/create-a-matlab-hello-world-application-with-reference-to-zivid-dot-net-sdk.html)

## Support

For more information about the Zivid cameras, please visit our
[Knowledge Base](https://support.zivid.com/latest). If you run into any
issues please check out
[Troubleshooting](https://support.zivid.com/latest/support/troubleshooting.html).

## License

Zivid Samples are distributed under the [BSD
license](https://github.com/zivid/zivid-matlab-samples/tree/master/LICENSE).
