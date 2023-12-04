clear; format short e
[x,data]=readDicom3D_j('002A Normal lo res.dcm',4);
cube = data(:,:,:,1);
figure(1); clf

subplot(4,4,1)
cube1 = cube(:,:,1);
imshow(cube1)

subplot(4,4,2)
cube13 = cube(:,:,13);
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


% cube56 = cube(:,:,100,1);
%image(cube(:,:,56,1)); 

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
c(q,u) = ((width-1)./(Nx-1)).*(q-1)+1;
r(q,u) = ((height-1)./(Nx-1)).*(u-1)+1;
%c(q,u)=floor(c(q,u));
%r(q,u)=floor(r(q,u));
%NewImg(q,u) = cube56(c(q,u),r(q,u));
end
end

 left = floor(c);
 right = left+1;
 alpha = c-left;
 up = floor(r);
 down = up+1;
 beta = r-up;
countu = 0;
countq = 0;
for q = 1:224
for u = 1:224
LeftUp = (1-alpha(q,u))*(1-beta(q,u)*cube104(left(q,u),up(q,u)));
RightUp = (alpha(q,u))*(1-beta(q,u))*cube104(right(q,u),up(q,u));
LeftDown = (1-alpha(q,u))*(beta(q,u))*cube104(left(q,u),down(q,u));
RightDown = (alpha(q,u))*(beta(q,u))*cube104(right(q,u),down(q,u));
NewImg (q,u) = LeftUp+RightUp+LeftDown+RightDown;
countu = countu +1;
end
countu = 0;
countq = countq +1;
end

figure(2);clf
original_cube = cube104;
imshow(original_cube)

figure(3); clf
adjusted_cube = NewImg;
imshow(adjusted_cube)

% subplot(4,4,1)
% cube1 = NewImg(:,:,1);
% image(cube1)
% 
% subplot(4,4,2)
% cube13 = NewImg(:,:,13);
% image(cube13)
% 
% subplot(4,4,3)
% cube26 = NewImg(:,:,26);
% image(cube26)
% 
% subplot(4,4,4)
% cube39 = NewImg(:,:,39);
% image(cube39)
% 
% subplot(4,4,5)
% cube52 = NewImg(:,:,52);
% image(cube52)
% 
% subplot(4,4,6)
% cube65 = NewImg(:,:,65);
% image(cube65)
% 
% subplot(4,4,7)
% cube78 = NewImg(:,:,78);
% image(cube78)
% 
% subplot(4,4,8)
% cube91 = NewImg(:,:,91);
% image(cube91)
% 
% subplot(4,4,9)
% cube104 = NewImg(:,:,104);
% image(cube104)
% 
% subplot(4,4,10)
% cube117 = NewImg(:,:,117);
% image(cube117)
% 
% subplot(4,4,11)
% cube130 = NewImg(:,:,130);
% image(cube130)
% 
% subplot(4,4,12)
% cube156 = NewImg(:,:,156);
% image(cube156)
% 
% subplot(4,4,13)
% cube168 = NewImg(:,:,168);
% image(cube168)
% 
% subplot(4,4,14)
% cube182 = NewImg(:,:,182);
% image(cube182)
% 
% subplot(4,4,15)
% cube195 = NewImg(:,:,195);
% image(cube195)
% 
% subplot(4,4,16)
% cube208 = NewImg(:,:,208);
% image(cube208)

%  while size(beta)<=223
%  K = numel(beta);
%  K=K+1;
%  beta(K) = 0;
%  down(K) = 0;
%  up(K) = 0;
%  r(K) = 0;
%  end

% NewImg = (1-alpha).*(1-beta).*cube(left,up,56)+(1-alpha).*(1-beta).*cube(right,up,56)...
%  +(1-alpha).*(1-beta).*cube(left,down,56)+(1-alpha).*(1-beta).*cube(right,down,56);


% % for h = 1:176
% % for w = 1:224
% % for d = 1:208
% % 
% % end 
% % 
% % end
% % 
% % end 
% 
% ((cube1(h,w,d)-1)/(Nx-1)).*()+1; 