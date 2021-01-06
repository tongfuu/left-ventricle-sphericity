clear all;
clc;
format short e
% 3Dheart at time 12 = cube (:,:,: 112);
[x,data]=readDicom3D('002A Normal lo res.dcm'); cube = data(:,:,:,12);
cube56 = cube(:,:,:,1);
%% Cube Define
dn = 9.0002;
ws = 24.8885;
Nx = dn.*ws;
Ny = dn.* 24959;
height = x.height;
heightspan = x.heightspan; width = x.width;
widthspan = x.widthspan;
depth = x.depth;
depthspan = x.depthspan; sampH = 1/(heightspan./height); sampW = 1/(widthspan./width); sampD = 1/(depthspan./depth); oldc = 1:1:224;
oldr = 1:1:176;
oldd = 1:1:208;
for q = 1:224
for u = 1:224
for e = 1:224
c(q,u,e) = ((width-1)./(Nx-1)).*(q-1)+1; r(q,u,e) = ((height-1)./(Nx-1)).*(u-1)+1; d(q,u,e) = ((depth-1)./(Nx-1)).*(e-1)+1; end
end
end
%% Cube Scaling
left = floor(c); right = left+1; alpha = c-left;
34
 up = floor(r); down = up+1; beta = r-up;
front = floor(d); back = front+1; gamma = d-front;
counte = 0;
countu = 0;
countq = 0;
for q = 1:223
for u = 1:223
for e = 1:223
LeftUpFront = (1-alpha(q,u,e))*(1-beta(q,u,e))*(1-gamma(q,u,e))*cube56(left(q,u,e),up(q,u,e),front(q,u,e)); RightUpFront = (alpha(q,u,e))*(1-beta(q,u,e))*(1-gamma(q,u,e))*cube56(right(q,u,e),up(q,u,e),front(q,u,e)); LeftUpBack= (1-alpha(q,u,e))*(1-beta(q,u,e))*(gamma(q,u,e))*cube56(left(q,u,e),up(q,u,e),back(q,u,e)); RightUpBack = (alpha(q,u,e))*(1-beta(q,u,e))*(gamma(q,u,e))*cube56(right(q,u,e),up(q,u,e),back(q,u,e)); LeftDownFront = (1-alpha(q,u,e))*(beta(q,u,e))*(1-gamma(q,u,e))*cube56(left(q,u,e),down(q,u,e),front(q,u,e)); RightDownFront = (alpha(q,u,e))*(beta(q,u,e))*(1-gamma(q,u,e))*cube56(right(q,u,e),down(q,u,e),front(q,u,e)); LeftDownBack = (1-alpha(q,u,e))*(beta(q,u,e))*(gamma(q,u,e))*cube56(left(q,u,e),down(q,u,e),back(q,u,e)); RightDownBack = (alpha(q,u,e))*(beta(q,u,e))*(gamma(q,u,e))*cube56(right(q,u,e),down(q,u,e),back(q,u,e));
NewImg (q,u,e) = LeftUpFront+RightUpFront+LeftUpBack+RightUpBack+LeftDownFront+RightDownFront+LeftDownB ack+RightDownBack;
counte= counte+1;
end
counte = 0;
countu = countu +1;
end
countu = 0;
countq = countq +1;
end
%% Image Processing
% otsu's method
%YZ middle slice
Heart2YZ = squeeze(NewImg(112,:,:));

imwrite(Heart2YZ, 'LV2YZ.jpg');
I2YZ = imresize(Heart2YZ(:,1:min(size(Heart2YZ(:,:,1))),1), [260 260]); Inew2YZ = imadjust(I2YZ, [0.15 0.9], []);
level2YZ = graythresh(Inew2YZ);
BW2YZ = imbinarize(Inew2YZ, level2YZ);
figure(1); clf
imshowpair(I2YZ, Inew2YZ, 'montage');
title('OG YZ and Resized YZ for Processing')
figure(2); clf
imshowpair(I2YZ, BW2YZ, 'montage');
title('OG YZ and Binarized YZ')
figure(3); clf
Inew2YZcanny = imadjust(I2YZ, [0.3 0.9], []); BWedge2YZ = edge(Inew2YZcanny, 'Canny'); imshowpair(I2YZ, BWedge2YZ, 'montage'); title('OG YZ and Edge Detected YZ')
% trying to trace regional boundary
imwrite(Inew2YZ, 'LV2YZblackandwhite.jpg')
figure(4); clf
Itrace2YZ = imread('LV2YZblackandwhite.jpg');
BWtrace2YZ = imbinarize(Itrace2YZ);
[B2YZ, L2YZ] = bwboundaries(BWtrace2YZ, 'noholes'); imshowpair(I2YZ, (label2rgb(L2YZ, @jet, [.5 .5 .5])), 'montage') hold on
for k2YZ = 1:length(B2YZ)
boundary2YZ = B2YZ{k2YZ};
plot(boundary2YZ(:,2), boundary2YZ(:, 1), 'w', 'LineWidth', 2) end
title('OG YZ and Boundary Traced YZ')
% doing the XY plane
Heart2XY = squeeze(NewImg(:,:,112));
imwrite(Heart2XY, 'LV2XY.jpg');
I2XY = imresize(Heart2XY(:,1:min(size(Heart2XY(:,:,1))),1), [260 260]); Inew2XY = imadjust(I2XY, [0.3 0.9], []);
level2XY = graythresh(Inew2XY);
BW2XY = imbinarize(Inew2XY, level2XY);
figure(5); clf

 imshowpair(I2XY, Inew2XY, 'montage'); title('OG XY and Resized XY for Processing') figure(6); clf
imshowpair(I2XY, BW2XY, 'montage'); title('OG XY and Binarized XY');
figure(7); clf
Inew2XYcanny = imadjust(I2XY, [0.4 0.9], []);
BWedge2XY = edge(Inew2XYcanny, 'Canny'); imshowpair(I2XY, BWedge2XY, 'montage');
title('OG XY and Edge Detected XY')
imwrite(Inew2XY, 'LV2XYblackandwhite.jpg')
figure(8); clf
Itrace2XY = imread('LV2XYblackandwhite.jpg');
BWtrace2XY = imbinarize(Itrace2XY);
[B2XY, L2XY] = bwboundaries(BWtrace2XY, 'noholes'); imshowpair(I2XY, label2rgb(L2XY, @jet, [.5 .5 .5]), 'montage') hold on
for k2XY = 1:length(B2XY)
boundary2XY = B2XY{k2XY};
plot(boundary2XY(:,2), boundary2XY(:, 1), 'w', 'LineWidth', 2) end
title('OG XY and Boundary Traced XY') %doing the XZ plane
Heart2XZ = squeeze(NewImg(:,112,:));
imwrite(Heart2XZ, 'LV2XZ.jpg');
I2XZ = imresize(Heart2XZ(:,1:min(size(Heart2XZ(:,:,1))),1), [260 260]); Inew2XZ = imadjust(I2XZ, [0.2 0.8], []);
level2XZ = graythresh(Inew2XZ);
BW2XZ = imbinarize(Inew2XZ, level2XZ);
figure(9); clf
imshowpair(I2XZ, Inew2XZ, 'montage')
title('OG XZ and Resized XZ for Processing')
figure(10); clf
imshowpair(I2XZ, BW2XZ, 'montage');
title('OG XZ and Binarized XZ')
figure(11); clf
Inew2XZcanny = imadjust(I2XZ, [0.3 0.8], []);
BWedge2XZ = edge(Inew2XZcanny, 'Canny');
imshowpair(I2XZ, BWedge2XZ, 'montage');
title('OG XZ and Edge Detected XZ')
imwrite(Inew2XZ, 'LV2XZblackandwhite.jpg')

figure(12); clf
Itrace2XZ = imread('LV2XZblackandwhite.jpg');
BWtrace2XZ = imbinarize(Itrace2XZ);
[B2XZ, L2XZ] = bwboundaries(BWtrace2XZ, 'noholes'); imshowpair(I2XZ, label2rgb(L2XZ, @jet, [.5 .5 .5]), 'montage') hold on
for k2XZ = 1:length(B2XZ)
boundary2XZ = B2XZ{k2XZ};
plot(boundary2XZ(:,2), boundary2XZ(:, 1), 'w', 'LineWidth', 2) end
title('OG XZ and Boundary Traced XZ')