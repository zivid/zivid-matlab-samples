% Import ZDF point cloud.

% The Zivid3D.zdf file has to be in the same folder as this sample script.
Filename = 'Zivid3D.zdf';

% Reading a .ZDF point cloud.
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(Filename);

% Creating a point cloud object.
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;
pc=pointCloud(XYZ,'color',double(Image)./255);

% Displaying the RGB image.
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(Image);
pbaspect([1920 1200 1])

% Displaying the Z component.
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(Z);
pbaspect([1920 1200 1])
colormap jet
colorbar

% Visualizing the point cloud.
figure('units','normalized','outerposition',[0 0 1 1])
pcshow(pc);
view([0 -90]);
set(gca, 'visible', 'off')