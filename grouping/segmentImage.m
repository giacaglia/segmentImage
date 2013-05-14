function [ ] = segmentImage( name_of_file )


%% Compute global Pb and hierarchical segmentation for an example image.
addpath(fullfile(pwd,'lib'));

%% 1. compute globalPb
close all; clc;

imgFile = name_of_file
if strcmp(name_of_file(size(name_of_file,2)-3:size(name_of_file,2)), '.jpg'),
    outFile = strcat(name_of_file(1:size(name_of_file,2)-4), '_gPb.mat');
    ucm2File = strcat(name_of_file(1:size(name_of_file,2)-4), '_ucm2.mat');
    ucmBmp = strcat(name_of_file(1:size(name_of_file,2)-4), '_ucm.bmp');
elseif strcmp(name_of_file(size(name_of_file,2)-4:size(name_of_file,2)), '.jpeg'),
    outFile = strcat(name_of_file(1:size(name_of_file,2)-5), '_gPb.mat');
    ucm2File = strcat(name_of_file(1:size(name_of_file,2)-5), '_ucm2.mat');
    ucmBmp = strcat(name_of_file(1:size(name_of_file,2)-5), 'ucm.bmp');
end

imgFile
outFile
gPb_orient = globalPb(imgFile, outFile);

%% 2. compute Hierarchical Regions

% for boundaries
ucm = contours2ucm(gPb_orient, 'imageSize');
imwrite(ucm, ucmBmp);

% for regions
ucm2 = contours2ucm(gPb_orient, 'doubleSize');
save(ucm2File,'ucm2');

%% 3. usage example
close all; clc;

%load double sized ucm
load(ucm2File, 'ucm2');

% convert ucm to the size of the original image
ucm = ucm2(3:2:end, 3:2:end);

% get the boundaries of segmentation at scale k in range [0 1]
k = 0.4;
bdry = (ucm >= k);

% get the partition at scale k without boundaries:
labels2 = bwlabel(ucm2 <= k);
labels = labels2(2:2:end, 2:2:end);

figure;imshow(imgFile);
figure;imshow(labels,[]);colormap(jet);

%% Save the Segmented Images under directory
createSegmentedImages( name_of_file, labels );

%% Save the Contour of the Images under directory
createContourImages( name_of_file,  labels );

end

