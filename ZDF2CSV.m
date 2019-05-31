% This example shows how to convert a Zivid point cloud from a .ZDF file
% format to a .CSV file format.

% Reading a .ZDF point cloud. The "Zivid3D.zdf" file has to be in the same folder as the "ReadZDF" file.
FilenameZDF = 'Zivid3D.zdf';
FilenameCSV = 'Zivid3D.csv';
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

pts = [X Y Z round(255*R) round(255*G) round(255*B) Contrast];
% pts = [X Y Z];

parts = ceil(length(pts) / 1000000);

%writematrix(pts,FilenameTXT,'Delimiter',',');
%csvwrite(FilenameCSV,pts);
dlmwrite(FilenameCSV,pts,'delimiter',',','precision','%.3f','newline','pc');
if parts > 1
    for i=1:parts
        index = strfind(FilenameCSV,'.');
        Filename = strcat(FilenameCSV(1:index-1),'_part_',num2str(i),FilenameCSV(index:end));
        last = i*1000000;
        if last > length(pts)
            last = length(pts);
        end
        %csvwrite(Filename,pts(((i-1)*1000000+1):last,:));
        dlmwrite(Filename,pts(((i-1)*1000000+1):last,:),'delimiter',',','precision','%.3f','newline','pc');
        %writematrix(pts(((i-1)*1000000+1):last,:),Filename,'Delimiter',',');
    end
end