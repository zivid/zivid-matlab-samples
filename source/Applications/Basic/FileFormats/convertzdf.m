function convertzdf(Filename,varargin)

% convertzdf(Filename,Fileformat)
%
% Convert from ZDF to your preferred format
% Example: covertzdf('Zivid3D.zdf','ply')
%
% Available formats:
%     .ply - Polygon File Format
%     .csv,.txt - [X, Y, Z, R, G, B, Contrast]
%     .png,.jpg,.bmp,.tiff - 2D RGB image   
%
% INPUT:
% Filename - File to convert
% Fileformat - File format
%     'ply' - Convert to PLY
%     'csv' - Convert to CSV
%     'txt' - Convert to TXT
%     'jpg' - Covnert to JPEG (3D->2D)
%     'tiff' - Covnert to TIFF (3D->2D)
%     'png' - Covnert to Portable Network Graphics (3D->2D)
%     'bmp' - Covnert to Windows bitmap (3D->2D)

if strcmp(Filename(end-3:end),'.zdf')
    
    % Reading a .ZDF point cloud.
    [X,Y,Z,R,G,B,Image,Contrast] = zdfread(Filename);

    % Removing extension from file name.
    Filename = Filename(1:end-4);
    
    for i = 1:nargin-1
        if strcmp(varargin{i},'ply')
            convert2ply(X,Y,Z,Image,strcat(Filename,'.ply'))
        elseif strcmp(varargin{i},'csv')
            convert2csv(X,Y,Z,R,G,B,Contrast,strcat(Filename,'.csv'))
        elseif strcmp(varargin{i},'txt')
            convert2csv(X,Y,Z,R,G,B,Contrast,strcat(Filename,'.txt'))
        elseif strcmp(varargin{i},'png')
            convert22d(Image, strcat(Filename,'.png'));
        elseif strcmp(varargin{i},'jpg')
            convert22d(Image, strcat(Filename,'.jpg'));
        elseif strcmp(varargin{i},'bmp')
            convert22d(Image, strcat(Filename,+'.bmp'));
        elseif strcmp(varargin{i},'tiff')
            convert22d(Image, strcat(Filename,+'.tiff'));
        end
    end
else
    disp('Input file is not in ZDF format')
end

end

function convert2ply(X,Y,Z,Image,Filename)

% convert2ply(X,Y,Z,Image,Filename)
%
% Convert to PLY
%
% INPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% Image - Color image (uint8 - 0 to 255)
% Filename - File name with extension

disp(['Converting to ',sprintf('%s',Filename(end-2:end))])

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

disp(['Saving the frame to ',sprintf('%s',Filename)])
pcwrite(pc,Filename,'Encoding','binary');

end

function convert2csv(X,Y,Z,R,G,B,Contrast,Filename)

% convert2csv(X,Y,Z,R,G,B,Contrast,Filename)
%
% Convert to CSV
%
% INPUT:
% X - x data in a matrix
% Y - y data in a matrix
% Z - z data in a matrix
% R - Red color band from color image (scaled from 0 to 1)
% G - Green color band from color image (scaled from 0 to 1)
% B - Blue color band from color image (scaled from 0 to 1)
% Contrast - Contrast image / quality image (float)
% Filename - File name with extension

disp(['Converting to ',sprintf('%s',Filename(end-2:end))])

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

Pointcloud = [X Y Z round(R*255) round(G*255) round(B*255) Contrast];

disp(['Saving the frame to ',sprintf('%s',Filename),', this may take a few minutes'])
dlmwrite(Filename,Pointcloud,'delimiter',',','precision','%.3f','newline','pc');

end

function convert22d(Image, Filename)

% convert22d(Image,Filename)
%
% Convert to 2D image
%
% INPUT:
% Image - Color image (uint8 - 0 to 255)
% Filename - File name with extension

disp(['Converting to ',sprintf('%s',Filename(end-2:end))])
disp(['Saving the frame to ',sprintf('%s',Filename)])
imwrite(Image,Filename);

end