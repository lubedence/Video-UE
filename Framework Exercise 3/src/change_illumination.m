function output = change_illumination(frame, luma_factor)
    %---------------------------------------------------------------------
    % Task a: Adjust brightness and resize foreground object
    %---------------------------------------------------------------------
    hsv = rgb2hsv(frame);   
    hsv(:,:,3) = hsv(:,:,3) * luma_factor;
    
    output = hsv2rgb(hsv);
end

