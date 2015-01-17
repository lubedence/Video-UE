%xpos, ypos: position for foreground (fg) in background (bg)
function result = merge(xpos, ypos, bg, fg, foreground_map )
    %---------------------------------------------------------------------
    % Task c: Merge foreground and background
    %---------------------------------------------------------------------
    fg_map = zeros(size(bg));
    fg_map(ypos:ypos+size(foreground_map,1)-1,xpos:xpos+size(foreground_map,2)-1, :) = repmat(foreground_map, [1 1 3]); %creates fg map content
    
    foreground = zeros(size(bg));
    foreground(ypos:ypos+size(fg,1)-1,xpos:xpos+size(fg,2)-1,:) = fg; %creates fg content
   
    
    foreground = foreground .* fg_map; % foreground is 0 where fg map is 0 and the respective value of the fg when 1
    background = bg .* (1 - fg_map) / 255; %bg is 0 where the fg map is 1 and the respective value of the bg when 1
    result = foreground + background; %element wise addition of fg and bg. when bg isnt 0 fg is and vice versa
end