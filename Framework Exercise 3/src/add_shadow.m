%xpos, ypos: position for foreground shadow in background
function bg_with_shadow = add_shadow(xpos, ypos, bg, foreground_map )
    %---------------------------------------------------------------------
    % Task b: Add shadow of foreground object to background
    %--------------------------------------------------------------------- 
    
    s = imtransform(foreground_map, maketform('projective',[10 -3 0; 10 5 0; 0 0 1]), 'XYScale', [12 22]);
    h = fspecial('gaussian', [5 5]);
    s = imfilter(double(s),h);
    
    shadow = zeros(size(bg, 1), size(bg,2));
    shadow(ypos:ypos+size(s,1)-1,xpos:xpos+size(s,2)-1) = s;

    bg_with_shadow = zeros(size(bg));
    
    colorShadow = [20 20 20];
    t = 0.8;
    for i = 1:3
        bg_with_shadow(:,:,i) = shadow * colorShadow(i) * t +  (double(bg(:,:,i)) .* shadow) * (1-t) +  (double(bg(:,:,i)) .* (1-shadow));
    end

end

