function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
    
    cost = Hfc ./ (Hfc + Hbc);
    cost(isnan(cost))=0;
    
    
    
    foreground_map=zeros(size(frames,1),size(frames,2),size(frames,4));
    for i = 1:size(frames,4)
        
        foreground_map(:,:,i) = (frames(:,:,1,i) + frames(:,:,2,i) + frames(:,:,3,i))/3;
        
    %----------------------------------------------------------------------
    % Task e: Filter cost-volume with guided filter
    %----------------------------------------------------------------------
 
    
    %----------------------------------------------------------------------
    % Task f: delete regions which are not connected to foreground scribble
    %----------------------------------------------------------------------
    

    %----------------------------------------------------------------------
    % Task g: Guided feathering
    %----------------------------------------------------------------------
    
    
    end
    
end
