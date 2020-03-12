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

height = size(pc.Location,1);
width = size(pc.Location,2);

% Iterating over the point cloud and displaying X, Y, Z, R, G, B, and Contrast
% for central 10 x 10 pixels
pixels_to_display = 10;
for i = (height - pixels_to_display) / 2 + 1:(height + pixels_to_display) / 2 + 1
    for j = (width - pixels_to_display) / 2 + 1:(width + pixels_to_display) / 2 + 1
        disp(['Values at pixel (',sprintf('%d',i),' , ',sprintf('%d',j),'): X:',sprintf('%.1f',pc.Location(i,j,1)),' Y:',sprintf('%.1f',pc.Location(i,j,2)),' Z:',sprintf('%.1f',pc.Location(i,j,3)),' R:',sprintf('%d',pc.Color(i,j,1)),' G:',sprintf('%d',pc.Color(i,j,2)),' B:',sprintf('%d',pc.Color(i,j,3)),' Contrast:',sprintf('%.1f',Contrast(i,j))]);
    end
end

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