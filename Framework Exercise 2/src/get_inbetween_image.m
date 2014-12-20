
function new_image = get_inbetween_image(image, u, v)
    %---------------------------------------------------------------------
    % Task b: Generate new x- and y-values of new frame
    %---------------------------------------------------------------------
    [height, width, ~] = size(image);
    
    image = double(image);
    
    %generate an index matrix defining what pixels shall be taken form 'image'
    [x,y] = meshgrid(1:width, 1:height);
    %add half the optical flow vectors as offset to generate the inbetween image
    x = x + -(u*0.5);
    y = y + -(v*0.5);
    
    %make sure we don't exceed image boundries
    x = min(max(x, 1), width);
    y = min(max(y,1), height);
 
    %---------------------------------------------------------------------
    % Task c: Generate new frame
    %---------------------------------------------------------------------
    
    %for every color channel, use the pixel offsets calculated with the flow vectors
    new_image = zeros(size(image));
    new_image(:,:,1) = interp2(image(:,:,1),x,y);
    new_image(:,:,2) = interp2(image(:,:,2),x,y);
    new_image(:,:,3) = interp2(image(:,:,3),x,y);
    
end
