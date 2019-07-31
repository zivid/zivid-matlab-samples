% Convert ZDF point cloud to PLY file format.

% The Zivid3D.zdf file has to be in the same folder as this sample script.
FilenameZDF = 'Zivid3D.zdf';
FilenamePLY = 'Zivid3D.ply';

% Reading a .ZDF point cloud.
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(FilenameZDF);

% Creating a point cloud.
XYZ(:,:,1) = X;
XYZ(:,:,2) = Y;
XYZ(:,:,3) = Z;

% Replacing NaNs with Zeros.
XYZ(isnan(XYZ)) = 0;

% Switching rows and columns.
XYZ = permute(conj(XYZ),[2,1,3]);
Image = permute(conj(Image),[2,1,3]);

% Creating a point cloud object.
pc = pointCloud(XYZ,'color',Image);

% Saving to a .PLY file format.
pcwrite(pc,FilenamePLY,'Encoding','binary');