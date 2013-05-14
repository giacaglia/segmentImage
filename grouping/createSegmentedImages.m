function [] = createSegmentedImages(name_of_image, labels)
%createSegmentedImages Creates and saves each image at Winston/Color and
%needs to run example before this script


    image = imread(name_of_image);
    segment = labels;
    
    [m, n, o] = size(image);
    Asize = max(max(segment));
    A = zeros(1, Asize);
    index = 1;
    A(1,1) = segment(1,1);
    for ii = 1:m, 
        for jj = 1:n,
            notFound = true;
            for kk = 1:Asize,
                if ( segment(ii, jj) == A(1, kk) ),
                    notFound = false;
                end
            end
            if (notFound),
                index = index + 1;
                A(1, index) = segment(ii, jj);
            end
        end
    end 
    
    if strcmp(name_of_image(size(name_of_image,2)-3:size(name_of_image,2)), '.jpg'),
        prefixOfImage = name_of_image(1:size(name_of_image,2)-4);
    elseif strcmp(name_of_image(size(name_of_image,2)-4:size(name_of_image,2)), '.jpg'),
        prefixOfImage = name_of_image(1:size(name_of_image,2)-5);
    end

    mkdir(prefixOfImage);
    for nImage = 1:Asize,
        returnedImage = zeros(m, n, o);
        maskedImage = zeros(m, n, o);
        for ii = 1:m,
            for jj = 1:n,
                if (segment(ii, jj) == A(1, nImage)),
                    for kk = 1:o,
                        returnedImage(ii, jj, kk) = image(ii, jj, kk);
                        maskedImage(ii, jj, kk) = 1;
                    end
                end
            end
        end
        returnedImage = returnedImage / max(max(max(returnedImage)));
        nameOfImage = strcat(prefixOfImage, '/cropped', num2str(nImage), '.jpg');
        imwrite(returnedImage, nameOfImage, 'jpg');
        nameOfMask = strcat(prefixOfImage, '/cropped', num2str(nImage), '_mask' ,'.jpg');
        imwrite(maskedImage, nameOfMask, 'jpg');
    end

    
end

