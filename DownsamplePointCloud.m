% Import ZDF point cloud and downsample it.

% The "Zivid3D.zdf" file has to be in the same folder as the "ReadZDF" file.
Filename = 'Zivid3D.zdf';

% Reading a .ZDF point cloud.
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(Filename);

% Creating a point cloud object.
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;
pc=pointCloud(XYZ,'color',double(Image)./255);

% Downsampling the point cloud.
[X_new,Y_new,Z_new,Image_new] = downsample(X,Y,Z,Image,Contrast,4);
XYZ_new(:,:,1) = X_new;
XYZ_new(:,:,2) = Y_new;
XYZ_new(:,:,3) = Z_new;
pc_new = pointCloud(XYZ_new,'color',double(Image_new)./255);

% Displaying RGB and Depth images.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)
imagesc(Image);
subplot(2,2,2)
imagesc(Image_new);
subplot(2,2,3)
imagesc(Z);
colormap jet
colorbar
subplot(2,2,4)
imagesc(Z_new);
colormap jet
colorbar
pbaspect([1920 1200 1])

%Visualizing the point clouds.
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc);
view([0 -90]);
set(gca, 'visible', 'off')
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc_new);
view([0 -90]);
set(gca, 'visible', 'off')