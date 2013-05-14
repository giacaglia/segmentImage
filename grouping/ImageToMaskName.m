function [ new_img ] = ImageToMaskName( name_of_file )
%IMAGETOBMPNAME The name of the image is transformed to the
% name of the bmp file

if strcmp(name_of_file(size(name_of_file,2)-3:size(name_of_file,2)), '.jpg'),
    maskFileName = strcat(name_of_file(1:size(name_of_file,2)-4), '_mask.jpg');
elseif strcmp(name_of_file(size(name_of_file,2)-4:size(name_of_file,2)), '.jpeg'),
    maskFileName = strcat(name_of_file(1:size(name_of_file,2)-5), '_mask.jpg');
end

im = imread(maskFileName);
new_img = zeros(size(im,1), size(im,2), size(im,3));

for i = 1:size(im,1),
    for j = 1:size(im,2),
        if im(i,j,1) == 0 && im(i,j,2) == 0 && im(i,j,3) == 0,
            neighbors = getNeighbors(i,j, size(im,1), size(im,2));
            for m = 1: size(neighbors,2),
                neighbor_m = neighbors(:,m);
                new_i = neighbor_m(1);
                new_j = neighbor_m(2);
                if im(new_i,new_j,1) ~= 0 || im(new_i,new_j,2) ~= 0 || im(new_i,new_j,3) ~= 0 
                    new_img(new_i,new_j,1) = 255;
                    new_img(new_i,new_j,2) = 255;
                    new_img(new_i,new_j,3) = 255;
                    break;
                end
            end
        end
    end
end

end

