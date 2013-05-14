function [segment] = segmentImageInto3000Pixels(prefixOfImage)
    im = imread(strcat(prefixOfImage, '.jpg'));
    seg_im = imread(strcat(prefixOfImage, '_ucm.bmp'));
    array = [];
    w = size(im,1);
    h = size(im,2);

    for i = 1:size(seg_im,1)
        for j = 1:size(seg_im,2),
            found = false;
            if ~isempty(array)
                for k = 1:size(array,2),
                    if seg_im(i,j) == array(k),
                        found = true;
                        break;
                    end
                end
            end
            if ~found,
                array = [array, seg_im(i,j)];
            end
        end
    end

    array = sort(array);

    l = size(array,2);

    %cabeca é uns 5% da imagem.
    new_bdry = ones(size(im,1), size(im,2));
    num_seg_images = 0;
    total_num_images = floor(w*h/3000);

    if total_num_images < 4,
        total_num_images = 4;
    end
    if total_num_images > 15,
        total_num_images = 15;
    end


    while num_seg_images < total_num_images
       found = false;
       for i = 1:size(seg_im,1),
           for j = 1:size(seg_im,2),
               if (seg_im(i,j) == array(l-num_seg_images)),
                   found = true;
                   new_bdry(i,j) = 0;
               end
           end
       end
       if found,
           num_seg_images = num_seg_images + 1;
       end
    end
    segment = bwlabel(new_bdry);
end