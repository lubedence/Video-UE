%xpos, ypos: position for foreground (fg) in background (bg)
function result = merge(xpos, ypos, bg, fg, foreground_map )
    %---------------------------------------------------------------------
    % Task c: Merge foreground and background
    %---------------------------------------------------------------------
    fg_map = zeros(size(bg));
    fg_map(ypos:ypos+size(foreground_map,1)-1,xpos:xpos+size(foreground_map,2)-1, :) = repmat(foreground_map, [1 1 3]);
    
    foreground = zeros(size(bg));
    foreground(ypos:ypos+size(fg,1)-1,xpos:xpos+size(fg,2)-1,:) = fg;
   
    
    foreground = foreground .* fg_map;
    background = bg .* (1 - fg_map);
    result = foreground*255 + background;
    imshow(result/255);
end