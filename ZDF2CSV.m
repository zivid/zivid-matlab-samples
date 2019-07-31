% Convert ZDF point cloud to TXT format.

% The "Zivid3D.zdf" file has to be in the same folder as the "ReadZDF" file.
FilenameZDF = 'Zivid3D.zdf';
FilenameCSV = 'Zivid3D.csv';

% Reading a .ZDF point cloud.
[X,Y,Z,R,G,B,Image,Contrast] = zdfread(FilenameZDF);

X = reshape(X', [], 1);
Y = reshape(Y', [], 1);
Z = reshape(Z', [], 1);
R = reshape(R', [], 1);
G = reshape(G', [], 1);
B = reshape(B', [], 1);
Contrast = reshape(Contrast', [], 1);
mask = isnan(X);
X(mask) = [];
Y(mask) = [];
Z(mask) = [];
R(mask) = [];
G(mask) = [];
B(mask) = [];
Contrast(mask) = [];

pts = [X Y Z round(R*255) round(G*255) round(B*255) Contrast];
% pts = [X Y Z];
dlmwrite(FilenameCSV,pts,'delimiter',',','precision','%.3f','newline','pc');