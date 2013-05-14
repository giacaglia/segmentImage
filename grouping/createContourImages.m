function [ ] = createContourImages(name_of_image, labels )
%createContourImages 

    contour = labels;
    Asize = max(max(contour));
    A = zeros(1, Asize);
    index = 1;
    A(1,1) = contour(1,1);
    [m, n, o] = size(contour);
    for ii = 1:m, 
        for jj = 1:n,
            notFound = true;
            for kk = 1:Asize,
                if ( contour(ii, jj) == A(1, kk) ),
                    notFound = false;
                end
            end
            if (notFound),
                index = index + 1;
                A(1, index) = contour(ii, jj);
            end
        end
    end
    
    if strcmp(name_of_image(size(name_of_image,2)-3:size(name_of_image,2)), '.jpg'),
        prefixOfImage = name_of_image(1:size(name_of_image,2)-4);
    elseif strcmp(name_of_image(size(name_of_image,2)-4:size(name_of_image,2)), '.jpg'),
        prefixOfImage = name_of_image(1:size(name_of_image,2)-5);
    end
    
    for nImage = 1:Asize,
        maskedImage = zeros(m, n, o);
        contourImage = zeros(m,n,3);
        for ii = 1:m,
            for jj = 1:n,
                if (contour(ii, jj) == A(1, nImage)),
                    for kk = 1:o,
                        maskedImage(ii, jj, kk) = 255;
                    end
                end
            end
        end
        
        for ii = 1:m
            for jj = 1:n,
                if maskedImage(ii,jj,1) == 255
                    neighbors = getNeighbors( ii, jj, m, n );
                    for kk = 1:size(neighbors,2),
                        neighbor_k = neighbors(:,kk);
                        new_ii = neighbor_k(1);
                        new_jj = neighbor_k(2);
                        if maskedImage(new_ii, new_jj, 1) ~= 255,
                            contourImage(ii, jj, 1) = 255;
                            contourImage(ii, jj, 2) = 255;
                            contourImage(ii, jj, 3) = 255;
                        end
                    end
                end
            end
        end
        nameOfBMP = strcat(prefixOfImage, '/cropped', num2str(nImage), '.bmp');
        imwrite(contourImage, nameOfBMP,'bmp');
    end

end

