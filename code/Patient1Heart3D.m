clear; format short e
[x,data]=readDicom3D_j('002A Normal lo res.dcm');
cube = data(:,:,:,25);

%% Old X-Y Heart Slices (Transverse plane)
figure(1); clf

subplot(4,4,1)
cube1 = cube(:,:,1);
imshow(cube1)

subplot(4,4,2)
cube13 = cube(:,:,2);
imshow(cube13)

subplot(4,4,3)
cube26 = cube(:,:,26);
imshow(cube26)

subplot(4,4,4)
cube39 = cube(:,:,39);
imshow(cube39)

subplot(4,4,5)
cube52 = cube(:,:,52);
imshow(cube52)

subplot(4,4,6)
cube65 = cube(:,:,65);
imshow(cube65)

subplot(4,4,7)
cube78 = cube(:,:,78);
imshow(cube78)

subplot(4,4,8)
cube91 = cube(:,:,91);
imshow(cube91)

subplot(4,4,9)
cube104 = cube(:,:,104);
imshow(cube104)

subplot(4,4,10)
cube117 = cube(:,:,117);
imshow(cube117)

subplot(4,4,11)
cube130 = cube(:,:,130);
imshow(cube130)

subplot(4,4,12)
cube156 = cube(:,:,156);
imshow(cube156)

subplot(4,4,13)
cube168 = cube(:,:,168);
imshow(cube168)

subplot(4,4,14)
cube182 = cube(:,:,182);
imshow(cube182)

subplot(4,4,15)
cube195 = cube(:,:,195);
imshow(cube195)

subplot(4,4,16)
cube208 = cube(:,:,208);
imshow(cube208)
cube = data(:,:,:,1);
%% Old X-Z Heart Slices (Saggital Plane)
figure(2); clf
subplot(4,4,1)
cube1 = squeeze(cube(:,1,:));
imshow(cube1)

subplot(4,4,2)
cube13 = squeeze(cube(:,13,:));
imshow(cube13)

subplot(4,4,3)
cube26 = squeeze(cube(:,26,:));
imshow(cube26)

subplot(4,4,4)
cube39 = squeeze(cube(:,39,:));
imshow(cube39)

subplot(4,4,5)
cube52 = squeeze(cube(:,52,:));
imshow(cube52)

subplot(4,4,6)
cube65 = squeeze(cube(:,65,:));
imshow(cube65)

subplot(4,4,7)
cube78 = squeeze(cube(:,78,:));
imshow(cube78)

subplot(4,4,8)
cube91 = squeeze(cube(:,91,:));
imshow(cube91)

subplot(4,4,9)
cube104 = squeeze(cube(:,104,:));
imshow(cube104)

subplot(4,4,10)
cube117 = squeeze(cube(:,117,:));
imshow(cube117)

subplot(4,4,11)
cube130 = squeeze(cube(:,130,:));
imshow(cube130)

subplot(4,4,12)
cube156 = squeeze(cube(:,156,:));
imshow(cube156)

subplot(4,4,13)
cube168 = squeeze(cube(:,168,:));
imshow(cube168)
%% Old Y-Z Heart Slices (Coronal plane)
figure(3); clf
subplot(4,4,1)
cube1 = squeeze(cube(1,:,:));
imshow(cube1)

subplot(4,4,2)
cube13 = squeeze(cube(13,:,:));
imshow(cube13)

subplot(4,4,3)
cube26 = squeeze(cube(26,:,:));
imshow(cube26)

subplot(4,4,4)
cube39 = squeeze(cube(39,:,:));
imshow(cube39)

subplot(4,4,5)
cube52 = squeeze(cube(52,:,:));
imshow(cube52)

subplot(4,4,6)
cube65 = squeeze(cube(65,:,:));
imshow(cube65)

subplot(4,4,7)
cube78 = squeeze(cube(78,:,:));
imshow(cube78)

subplot(4,4,8)
cube91 = squeeze(cube(91,:,:));
imshow(cube91)

subplot(4,4,9)
cube104 = squeeze(cube(104,:,:));
imshow(cube104)

subplot(4,4,10)
cube117 = squeeze(cube(117,:,:));
imshow(cube117)

subplot(4,4,11)
cube130 = squeeze(cube(130,:,:));
imshow(cube130)

subplot(4,4,12)
cube156 = squeeze(cube(156,:,:));
imshow(cube156)

subplot(4,4,13)
cube168 = squeeze(cube(168,:,:));
imshow(cube168)

subplot(4,4,14)
cube182 = squeeze(cube(182,:,:));
imshow(cube182)

subplot(4,4,15)
cube195 = squeeze(cube(195,:,:));
imshow(cube195)

subplot(4,4,16)
cube208 = squeeze(cube(208,:,:));
imshow(cube208)

cube56 = cube(:,:,:,1);
%% Cube Define
dn = 9.0002;
ws = 24.8885;
Nx = dn.*ws; 
Ny = dn.* 24959;
height = x.height;
heightspan = x.heightspan;
width = x.width;
widthspan = x.widthspan;
depth =  x.depth;
depthspan = x.depthspan;
sampH = 1/(heightspan./height);
sampW = 1/(widthspan./width);
sampD = 1/(depthspan./depth);
oldc = 1:1:224;
oldr = 1:1:176;
oldd = 1:1:208;
for q = 1:224
for u = 1:224
for e = 1:224
c(q,u,e) = ((width-1)./(Nx-1)).*(q-1)+1;
r(q,u,e) = ((height-1)./(Nx-1)).*(u-1)+1;
d(q,u,e) = ((depth-1)./(Nx-1)).*(e-1)+1;
end
end 
end
%% Cube Scaling
 left = floor(c);
 right = left+1;
 alpha = c-left;
 up = floor(r);
 down = up+1;
 beta = r-up;
 front = floor(d);
 back = front+1;
 gamma = d-front;
counte = 0;
countu = 0;
countq = 0;
for q = 1:223
for u = 1:223
for e = 1:223
LeftUpFront = (1-alpha(q,u,e))*(1-beta(q,u,e))*(1-gamma(q,u,e))*cube56(left(q,u,e),up(q,u,e),front(q,u,e));
RightUpFront = (alpha(q,u,e))*(1-beta(q,u,e))*(1-gamma(q,u,e))*cube56(right(q,u,e),up(q,u,e),front(q,u,e));
LeftUpBack= (1-alpha(q,u,e))*(1-beta(q,u,e))*(gamma(q,u,e))*cube56(left(q,u,e),up(q,u,e),back(q,u,e));
RightUpBack = (alpha(q,u,e))*(1-beta(q,u,e))*(gamma(q,u,e))*cube56(right(q,u,e),up(q,u,e),back(q,u,e));
LeftDownFront = (1-alpha(q,u,e))*(beta(q,u,e))*(1-gamma(q,u,e))*cube56(left(q,u,e),down(q,u,e),front(q,u,e));
RightDownFront = (alpha(q,u,e))*(beta(q,u,e))*(1-gamma(q,u,e))*cube56(right(q,u,e),down(q,u,e),front(q,u,e));
LeftDownBack = (1-alpha(q,u,e))*(beta(q,u,e))*(gamma(q,u,e))*cube56(left(q,u,e),down(q,u,e),back(q,u,e));
RightDownBack = (alpha(q,u,e))*(beta(q,u,e))*(gamma(q,u,e))*cube56(right(q,u,e),down(q,u,e),back(q,u,e));
NewImg (q,u,e) = LeftUpFront+RightUpFront+LeftUpBack+RightUpBack+LeftDownFront+RightDownFront+LeftDownBack+RightDownBack;
counte= counte+1;
end
counte = 0;
countu = countu +1;
end
countu = 0;
countq = countq +1;
end

%% New X-Y Heart Slices (Transverse plane)
figure(4); clf

subplot(4,4,1)
cube1 = NewImg(:,:,1);
imshow(cube1)

subplot(4,4,2)
cube13 = NewImg(:,:,13);
imshow(cube13)

subplot(4,4,3)
cube26 = NewImg(:,:,26);
imshow(cube26)

subplot(4,4,4)
cube39 = NewImg(:,:,39);
imshow(cube39)

subplot(4,4,5)
cube52 = NewImg(:,:,52);
imshow(cube52)

subplot(4,4,6)
cube65 = NewImg(:,:,65);
imshow(cube65)

subplot(4,4,7)
cube78 = NewImg(:,:,78);
imshow(cube78)

subplot(4,4,8)
cube91 = NewImg(:,:,91);
imshow(cube91)

subplot(4,4,9)
cube104 = NewImg(:,:,104);
imshow(cube104)

subplot(4,4,10)
cube117 = NewImg(:,:,117);
imshow(cube117)

subplot(4,4,11)
cube130 = NewImg(:,:,130);
imshow(cube130)

subplot(4,4,12)
cube156 = NewImg(:,:,156);
imshow(cube156)

subplot(4,4,13)
cube168 = NewImg(:,:,168);
imshow(cube168)

subplot(4,4,14)
cube182 = NewImg(:,:,182);
imshow(cube182)

subplot(4,4,15)
cube195 = NewImg(:,:,195);
imshow(cube195)

subplot(4,4,16)
cube208 = NewImg(:,:,208);
imshow(cube208)
%% New X-Z Heart Slices (Saggital Plane)
figure(5); clf

subplot(4,4,1)
cube1 = squeeze(NewImg(:,1,:));
imshow(cube1)

subplot(4,4,2)
cube13 = squeeze(NewImg(:,13,:));
imshow(cube13)

subplot(4,4,3)
cube26 = squeeze(NewImg(:,26,:));
imshow(cube26)

subplot(4,4,4)
cube39 = squeeze(NewImg(:,39,:));
imshow(cube39)

subplot(4,4,5)
cube52 = squeeze(NewImg(:,52,:));
imshow(cube52)

subplot(4,4,6)
cube65 = squeeze(NewImg(:,65,:));
imshow(cube65)

subplot(4,4,7)
cube78 = squeeze(NewImg(:,78,:));
imshow(cube78)

subplot(4,4,8)
cube91 = squeeze(NewImg(:,91,:));
imshow(cube91)

subplot(4,4,9)
cube104 = squeeze(NewImg(:,104,:));
imshow(cube104)

subplot(4,4,10)
cube117 = squeeze(NewImg(:,117,:));
imshow(cube117)
% [x,y] = getpts

subplot(4,4,11)
cube130 = squeeze(NewImg(:,130,:));
imshow(cube130)

subplot(4,4,12)
cube156 = squeeze(NewImg(:,156,:));
imshow(cube156)

subplot(4,4,13)
cube168 = squeeze(NewImg(:,168,:));
imshow(cube168)

subplot(4,4,14)
cube182 = squeeze(NewImg(:,182,:));
imshow(cube182)

subplot(4,4,15)
cube195 = squeeze(NewImg(:,195,:));
imshow(cube195)

subplot(4,4,16)
cube208 = squeeze(NewImg(:,208,:));
imshow(cube208)
%% New Y-Z Heart Slices (Coronal plane)
figure(6); clf
subplot(4,4,1)
cube1 = squeeze(NewImg(1,:,:));
imshow(cube1)

subplot(4,4,2)
cube13 = squeeze(NewImg(13,:,:));
imshow(cube13)

subplot(4,4,3)
cube26 = squeeze(NewImg(26,:,:));
imshow(cube26)

subplot(4,4,4)
cube39 = squeeze(NewImg(39,:,:));
imshow(cube39)

subplot(4,4,5)
cube52 = squeeze(NewImg(52,:,:));
imshow(cube52)

subplot(4,4,6)
cube65 = squeeze(NewImg(65,:,:));
imshow(cube65)

subplot(4,4,7)
cube78 = squeeze(NewImg(78,:,:));
imshow(cube78)

subplot(4,4,8)
cube91 = squeeze(NewImg(91,:,:));
imshow(cube91)

subplot(4,4,9)
cube104 = squeeze(NewImg(104,:,:));
imshow(cube104)

subplot(4,4,10)
cube117 = squeeze(NewImg(117,:,:));
imshow(cube117)

subplot(4,4,11)
cube130 = squeeze(NewImg(130,:,:));
imshow(cube130)

subplot(4,4,12)
cube156 = squeeze(NewImg(156,:,:));
imshow(cube156)

subplot(4,4,13)
cube168 = squeeze(NewImg(168,:,:));
imshow(cube168)

subplot(4,4,14)
cube182 = squeeze(NewImg(182,:,:));
imshow(cube182)

subplot(4,4,15)
cube195 = squeeze(NewImg(195,:,:));
imshow(cube195)

subplot(4,4,16)
cube208 = squeeze(NewImg(208,:,:));
imshow(cube208)
