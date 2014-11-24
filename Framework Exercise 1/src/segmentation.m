function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
    
    cost = Hfc ./ (Hfc + Hbc);
    cost(isnan(cost))=0;
    costBin = (cost > 0.5);
    
    foreground_map = zeros(size(frames,1),size(frames,2),size(frames,4));
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
    
    imageFilterRadius = 3;
    videoFilterRadius = 1;
    epsilon = 0.001;
    foreground_map =  guidedfilter_vid_color(frames, foreground_map, imageFilterRadius, videoFilterRadius, epsilon);
    
    %----------------------------------------------------------------------
    % Task f: delete regions which are not connected to foreground scribble
    %----------------------------------------------------------------------
    
    for i = 1:size(foreground_map,3)
        foreground_map(:,:,i) = keepConnected(foreground_map(:,:,i), FGScribbles);
    end
    
    %----------------------------------------------------------------------
    % Task g: Guided feathering
    %----------------------------------------------------------------------
    
    foreground_map =  guidedfilter_vid_color(frames, foreground_map, imageFilterRadius, videoFilterRadius, epsilon);
    
    
    foreground_map = foreground_map * 255;
    
    
end
