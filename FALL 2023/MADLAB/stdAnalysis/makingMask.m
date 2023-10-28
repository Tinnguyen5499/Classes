function [circleImage] = makingMask(pathway,sample,circleRadius,n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% Inputing data
fontSize = 20;
source = strcat(pathway,sample,'/frames/'); % assign pathway to frames
% destination = strcat(pathway,sample,'/output/'); % assign output pathway
frames = dir(strcat(source,'/*.png')); % assign list of frames
% numframes = length(frames)

%  for n = 1:numframes % for every frame
%         frame = strcat(source,frames(n).name)
% 
%  end 

frame = strcat(source,frames(1).name)

%% Creating Mask
%finding coordinates
originalImage = im2gray(imread(frame));
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(originalImage);
% Display the original gray scale image.
figure(n)
subplot(2, 2, 1);
imshow(originalImage, []);
% Change imshow to image() if you don't have the Image Processing Toolbox.
title('Original Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Position', get(0,'Screensize')); 
set(gcf,'name','Image Analysis Demo','numbertitle','off') 

% Initialize parameters for the circle,
[x_coord,y_coord,z]=impixel(im2gray(imread(frame)));

% such as it's location and radius.
circleCenterX = x_coord; 
circleCenterY = y_coord; % square area 0f 500*500 
circleRadius = circleRadius;    % big circle radius 
% Initialize an image to a logical image of the circle. 
circleImage = false(rows, columns); 
[x, y] = meshgrid(1:columns, 1:rows); 
circleImage((x - circleCenterX).^2 + (y - circleCenterY).^2 <= circleRadius.^2) = true; 
% Display it in the upper right plot. 
subplot(2,2,2); 
imshow(circleImage, []); 
% Change imshow to image() if you don't have the Image Processing Toolbox.
title('Circle Mask', 'FontSize', fontSize); 
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
drawnow;

% Mask the image with the circle.
if numberOfColorBands == 1
	maskedImage = originalImage; % Initialize with the entire image.
	maskedImage(~circleImage) = 0; % Zero image outside the circle mask.
%     binary_mask = orignalImage;
%     binary_mask(~circleImage)= 0;
else
	% Mask the image.
	maskedImage = bsxfun(@times, originalImage, cast(circleImage,class(originalImage)));
%     binary_mask= bsxfun(@times, originalImage, cast(binary_mask,class(originalImage)));
end

% Display it in the lower right plot. 
subplot(2, 3, 5); 
imshow(maskedImage, []); 
% Change imshow to image() if you don't have the Image Processing Toolbox.
title('Image masked with the circle.', 'FontSize', fontSize); 
drawnow

binary_Mask=logical(maskedImage);


% binary_Mask= originalImage(binary_Mask);
% 
% std= std2(binary_Mask);


end