function [ neighbors ] = getNeighbors( i, j, maxi, maxj )
%getNeighbors Gets the neighbors of an index in a matrix given that
%   the maximum index of i is maxi and anagolously maxj is the maximum of j
% Example:
%   >> neighbors = getNeighbors(1,1,3,3)
%   >> neighbors =
%
%     1     2     2
%     2     1     2
%   >> size(neighbors) 
%        2     3

    neighbors = [];
    listOfPossibleIs = [i];
    listOfPossibleJs = [j];
    if (i-1 > 0),
        listOfPossibleIs = [listOfPossibleIs, i-1];
    end
    if (i+1 <= maxi),
        listOfPossibleIs = [listOfPossibleIs, i+1];
    end
    if (j-1 > 0),
        listOfPossibleJs = [listOfPossibleJs, j-1];
    end
    if (j+1 <= maxj),
        listOfPossibleJs = [listOfPossibleJs, j+1];
    end

    for counter1 = 1:size(listOfPossibleIs,2),
        for counter2 = 1:size(listOfPossibleJs,2),
            if counter1 ~= 1  || counter2 ~= 1,
                neighbors = [neighbors, [listOfPossibleIs(counter1); listOfPossibleJs(counter2)]];
            end
        end
    end
    

end

