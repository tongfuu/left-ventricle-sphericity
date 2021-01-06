clear all; format short e

prompt = {'The file name','Time point','Repeat measurements for how many times: '};
dlgtitle = 'Input';
dims = [2 50];
definput = {'xxx.dcm','1','3'};
answer = inputdlg(prompt,dlgtitle,dims,definput)
filename = answer{1}
timepoint = str2num(answer{2})
iteration = str2num(answer{3})

[x,data]=readDicom3D_j(filename);

cube = data(:,:,:,timepoint);
%PlotOldCube(cube)
cube56 = cube(:,:,:,1);

%% Cube Define
height = x.height;
hs = x.heightspan;
width = x.width;
ws = x.widthspan;
depth =  x.depth;
ds = x.depthspan;
sampH = 1./(hs./height);
sampW = 1./(ws./width);
sampD = 1./(ds./depth);
dW = 0.1036; % patient 1
dH = 0.169; % patient 1
dD = 0.0972319; % patient 1
% dW = 0.0786; % patient 2
% dH = 1/sampH; % patient 2
% dD = 1/sampD; % patient 2

for q = 1:depth
for u = 1:depth
for e = 1:depth
c(q,u,e) = ((q-1)./(width-1)).*(ws/dW)+1;
r(q,u,e) = ((u-1)./(height-1)).*(hs/dH)+1;
d(q,u,e) = ((e-1)./(depth-1)).*(ds/dD)+1;
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
tw3=depth;
for q = 1:tw3
for u = 1:tw3
for e = 1:tw3
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

%% filtering
% XY 112

cube1 = NewImg(:,:,112);
Heart1XY = squeeze(cube1);
I2XY = imresize(Heart1XY(:,1:min(size(Heart1XY(:,:,1))),1), [260 260]);
Inew1XY = imadjust(I2XY, [0.2 0.8], []);
level1XY = graythresh(Inew1XY); 
BW1XY = imbinarize(Inew1XY, level1XY); 

% XZ 112

cube2 = NewImg(:,112,:);
Heart1XZ = squeeze(cube2);
I2XZ = imresize(Heart1XZ(:,1:min(size(Heart1XZ(:,:,1))),1), [260 260]);
Inew1XZ = imadjust(I2XZ, [0.2 0.8], []);
level1XZ = graythresh(Inew1XZ); 
BW1XZ = imbinarize(Inew1XZ, level1XZ); 

% YZ 112

cube3 = NewImg(112,:,:);
Heart1YZ = squeeze(cube3);
I1YZ = imresize(Heart1YZ(:,1:min(size(Heart1YZ(:,:,1))),1), [260 260]);
Inew1YZ = imadjust(I1YZ, [0.15 0.9], []);
level1YZ = graythresh(Inew1YZ); 
BW1YZ = imbinarize(Inew1YZ, level1YZ);

%% figure & select points
clear x1 y1 x2 y2 x3 y3 X1Y1 X2Y2 X3Y3 A1 A2 A3

figure(1);clf
ax1 = subplot(1,3,1)
imshow(Inew1XY)
ax2 = subplot(1,3,2)
imshow(Inew1XZ)
ax3 = subplot(1,3,3)
imshow(Inew1YZ)

for i=1:iteration
    clear x1 y1
    [x1,y1] = getpts(ax1);
    A(i) = fit_ellipse(x1,y1);
end

for i=1:iteration
    clear x2 y2
    [x2,y2] = getpts(ax2);
    B(i) = fit_ellipse(x2,y2);
end

for i=1:iteration
    clear x3 y3
    [x3,y3] = getpts(ax3);
    C(i) = fit_ellipse(x3,y3);
end

%% Calculation
x_avg = (sum([A.long_axis])+ sum([B.short_axis])) / (iteration*2)
y_avg = (sum([A.short_axis])+ sum([C.short_axis])) / (iteration*2)
z_avg = (sum([B.long_axis])+ sum([C.long_axis])) / (iteration*2)


ratio_y = y_avg/x_avg
ratio_z = z_avg/x_avg
str = sprintf('1 : %.2f : %.2f', ratio_y, ratio_z);
ratio =  sprintf('%.2f',1/ratio_z);
f = msgbox({'The ratio of x:y:z is';str;'';'SI: ';ratio},'info','help');
