function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
    
    cost = Hfc ./ (Hfc + Hbc);  %cost function
    cost(isnan(cost))=0; %nan to zero
    costBin = (cost > 0.5); %cost values to binary. 0-0.5 == background, else it's foreground
    
    foreground_map = zeros(size(frames,1),size(frames,2),size(frames,4)); %init output map
    %match every pixel of each frame to foreground(1) or background(0)
    %dependig on the costs.
    f=double(bins)/256.0;
    for i = 1:size(frames,4)    
        frameR = double(frames(:,:,1,i));
        frameG = double(frames(:,:,2,i));
        frameB = double(frames(:,:,3,i));
        
        histIDs=floor(frameR*f) + floor(frameG*f)*bins + floor(frameB*f)*bins*bins+1;
        foreground_map(:,:,i) = arrayfun(@(id) (costBin(id) ), histIDs); 
    end
    
    
    %----------------------------------------------------------------------
    % Task e: Filter cost-volume with guided filter
    %----------------------------------------------------------------------
    
    imageFilterRadius = 5; %radius for x,y - spatial
    videoFilterRadius = 1; %radius for z - temporal
    epsilon = 0.1;         %regularization parameter
    foregroundThreshold = 0.4; %needed to obtain a binary output
    foreground_map = guidedfilter_vid_color(frames, foreground_map, imageFilterRadius, videoFilterRadius, epsilon) > foregroundThreshold;
    
    %----------------------------------------------------------------------
    % Task f: delete regions which are not connected to foreground scribble
    %----------------------------------------------------------------------
    
    for i = 1:size(foreground_map,3)
        foreground_map(:,:,i) = keepConnected(foreground_map(:,:,i), FGScribbles);
    end
    
    %----------------------------------------------------------------------
    % Task g: Guided feathering
    %----------------------------------------------------------------------
    
    foreground_map =  guidedfilter_vid_color(frames, foreground_map, imageFilterRadius, videoFilterRadius, epsilon) * 255;
    
    
end
