function [XY,XZ,YZ] = PlotNewCube(NewImg)
%% New X-Y Heart Slices (Transverse plane)
% M = 50;
% for k=1:16
% figure(k); clf
% % subplot(4,4,k)
% cube2 = NewImg(:,:,M);
% Heart1XZ = squeeze(cube2);
% I1XZ = imresize(Heart1XZ(:,1:min(size(Heart1XZ(:,:,1))),1), [260 260]);
% Inew1XZ = imadjust(I1XZ, [0.3 0.9], []);
% level1XZ = graythresh(Inew1XZ); 
% BW1XZ = imbinarize(Inew1XZ, level1XZ); 
% subplot(4,1,1)
% imshowpair(I1XZ, Inew1XZ, 'montage');
% title('OG XY and Resized XY for Processing')
% subplot(4,1,2)
% imshowpair(I1XZ, BW1XZ, 'montage');
% title('OG XY and Binarized XY');
% subplot(4,1,3)
% Inew1XZcanny = imadjust(I1XZ, [0.4 0.9], []);
% BWedge1XZ = edge(Inew1XZcanny, 'Canny');
% imshowpair(I1XZ, BWedge1XZ, 'montage');
% title('OG XY and Edge Detected XY')
% imwrite(Inew1XZ, 'LV2XYblackandwhite.jpg')
% subplot(4,1,4)
% Itrace1XZ = imread('LV2XYblackandwhite.jpg'); 
% BWtrace1XZ = imbinarize(Itrace1XZ); 
% [B1XZ, L1XZ] = bwboundaries(BWtrace1XZ, 'noholes'); 
% imshowpair(I1XZ, label2rgb(L1XZ, @jet, [.5 .5 .5]), 'montage') 
% hold on 
% for k1XZ = 1:length(B1XZ) 
%     boundary1XZ = B1XZ{k1XZ}; 
%     plot(boundary1XZ(:,2), boundary1XZ(:, 1), 'w', 'LineWidth', 2)
% end 
% title('OG XY and Boundary Traced XY')
% %imshow(cube1)
% XY(k)=M;
% M = M+8;
% if M == 208
% M=M-1;
% end
% end
 
 
% New X-Z Heart Slices (Saggital Plane)
 
M = 84;
for k=1:16
figure(k); clf
% subplot(4,4,k)
cube2 = NewImg(:,M,:);
Heart1XZ = squeeze(cube2);
I1XZ = imresize(Heart1XZ(:,1:min(size(Heart1XZ(:,:,1))),1), [260 260]);
Inew1XZ = imadjust(I1XZ, [0.2 0.8], []);
level1XZ = graythresh(Inew1XZ); 
BW1XZ = imbinarize(Inew1XZ, level1XZ); 
subplot(4,1,1)
imshowpair(I1XZ, Inew1XZ, 'montage');
title('OG XZ and Resized XZ for Processing')
subplot(4,1,2)
imshowpair(I1XZ, BW1XZ, 'montage');
title('OG XZ and Binarized XZ');
subplot(4,1,3)
Inew1XZcanny = imadjust(I1XZ, [0.3 0.8], []);
BWedge1XZ = edge(Inew1XZcanny, 'Canny');
imshowpair(I1XZ, BWedge1XZ, 'montage');
title('OG XZ and Edge Detected XZ')
imwrite(Inew1XZ, 'LV2XZblackandwhite.jpg')
subplot(4,1,4)
Itrace1XZ = imread('LV2XZblackandwhite.jpg'); 
BWtrace1XZ = imbinarize(Itrace1XZ); 
[B1XZ, L1XZ] = bwboundaries(BWtrace1XZ, 'noholes'); 
imshowpair(I1XZ, label2rgb(L1XZ, @jet, [.5 .5 .5]), 'montage') 
hold on 
for k1XZ = 1:length(B1XZ) 
    boundary1XZ = B1XZ{k1XZ}; 
    plot(boundary1XZ(:,2), boundary1XZ(:, 1), 'w', 'LineWidth', 2)
end 
title('OG XZ and Boundary Traced XZ')
XZ(k)=M;
M = M+3;
if M == 208
M=M-1;
end
end
 
% %% New Y-Z Heart Slices (Coronal plane)
% M = 90;
% %figure(6); clf
% for k=1:16
% figure(k); clf
% % subplot(4,4,k)
% cube3 = NewImg(M,:,:);
% Heart1YZ = squeeze(cube3);
% I1YZ = imresize(Heart1YZ(:,1:min(size(Heart1YZ(:,:,1))),1), [260 260]);
% Inew1YZ = imadjust(I1YZ, [0.15 0.9], []);
% level1YZ = graythresh(Inew1YZ); 
% BW1YZ = imbinarize(Inew1YZ, level1YZ); 
% subplot(4,1,1)
% imshowpair(I1YZ, Inew1YZ, 'montage');
% title('OG YZ and Resized YZ for Processing')
% subplot(4,1,2)
% imshowpair(I1YZ, BW1YZ, 'montage');
% title('OG YZ and Binarized YZ');
% subplot(4,1,3)
% Inew1YZcanny = imadjust(I1YZ, [0.3 0.9], []);
% BWedge1YZ = edge(Inew1YZcanny, 'Canny');
% imshowpair(I1YZ, BWedge1YZ, 'montage');
% title('OG YZ and Edge Detected YZ')
% imwrite(Inew1YZ, 'LV2YZblackandwhite.jpg')
% subplot(4,1,4)
% Itrace1YZ = imread('LV2YZblackandwhite.jpg'); 
% BWtrace1YZ = imbinarize(Itrace1YZ); 
% [B1YZ, L1YZ] = bwboundaries(BWtrace1YZ, 'noholes'); 
% imshowpair(I1YZ, label2rgb(L1YZ, @jet, [.5 .5 .5]), 'montage') 
% hold on 
% for k1YZ = 1:length(B1YZ) 
%     boundary1YZ = B1YZ{k1YZ}; 
%     plot(boundary1YZ(:,2), boundary1YZ(:, 1), 'w', 'LineWidth', 2)
% end 
% title('OG YZ and Boundary Traced YZ')
% YZ(k)=M;
% M = M+3;
% if M == 208
% M=M-1;
% end
% end
end