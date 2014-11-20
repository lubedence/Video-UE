%   BOXFILTER   O(1) time box filtering using cumulative sum
%
%   - Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));
%   - Running time independent of r; 
%   - Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum);
%   - But much faster.
function imDst = boxfilter_vid(vidSrcC, r, rt)
    % the size of each local patch; N=(2r+1)^3 except for boundary pixels.
    [hei, wid, time] = size(vidSrcC);
    imDst = zeros(size(vidSrcC));

    % cumulative sum over Y axis
    imCum = cumsum(vidSrcC, 1);
    % difference over Y axis
    imDst(1:r+1, :, :) = imCum(1+r:2*r+1, :, :);
    imDst(r+2:hei-r, :, :) = imCum(2*r+2:hei, :, :) - imCum(1:hei-2*r-1, :, :);
    imDst(hei-r+1:hei, :, :) = repmat(imCum(hei, :, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :, :);

    % cumulative sum over X axis
    imCum = cumsum(imDst, 2);
    % difference over Y axis
    imDst(:, 1:r+1,:) = imCum(:, 1+r:2*r+1,:);
    imDst(:, r+2:wid-r,:) = imCum(:, 2*r+2:wid,:) - imCum(:, 1:wid-2*r-1,:);
    imDst(:, wid-r+1:wid,:) = repmat(imCum(:, wid,:), [1, r]) - imCum(:, wid-2*r:wid-r-1,:);

    %----------------------------------------------------------------------
    % Task d.	Extension of the guided image filter to a guided video 
    %           filter
    %----------------------------------------------------------------------
   
    
    
end



