close all
clear all


% the two stereo images
im1=double(rgb2gray(imread('Left image.jpg')));
imshow(im1,[]);
title('The reference image')

figure
im2=double(rgb2gray(imread('Right image.jpg')));
imshow(im2,[]);
title('The other image')

% lengtlen and widthidtlen
[len,width] = size(im1);

D=30;% sub region
N=12;% searclen widthindowidth 

% Difference and absolute difference
imgDiff=zeros(len,width,D);
err=zeros(len,width);
for i=1:D
    err(:,1:(width-i))=abs(im2(:,1:(width-i))- im1(:,(i+1):width));
e2=zeros(len,width);% calculate the sum in the window
    for y=(N+1):(len-N)
        for x=(N+1):(width-N)
            e2(y,x)=sum(sum(err((y-N):(y+N),(x-N):(x+N))));
        end
    end
    imgDiff(:,:,i)=e2;
end

dispMap=zeros(len,width); 
for x=1:width
   for y=1:len
       [val,id]=sort(imgDiff(y,x,:));
       if abs(val(1)-val(2))>10
           dispMap(y,x)=id(1);
        end
    end
end

figure;
imshow(dispMap,[])
title('The depth map between two images')
% display

[X,Y] = meshgrid(1:31:size(dispMap,2),1:31:size(dispMap,1));
% [U,V] = gradient(dispMap);% the differnce
figure;
% imshow(im1,[])
% hold on
quiver(X,Y)
title('directions')
% hold off