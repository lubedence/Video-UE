function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list,bins)     
    % load reference frame and its foreground and background scribbles
    bok=false;
    scribble_count=0;
    reference_frame=[];
    fg_scribbles=[];
    histo_fg=[];
    histo_bg=[];
    for j = 1:numel(file_list)
        frame_name = file_list(j).name;

        if (strcmp(frame_name(1),'s') == 1) % scribble files begin with s
           frame = imread([input_directory '/' frame_name]); %read image      
           scribble_count=scribble_count +1;
           frames_scribbles(:,:,:,scribble_count) = frame(:,:,:);             
        elseif (strcmp(frame_name(1),'r') == 1) % reference file begin with r
           frame = imread([input_directory '/' frame_name]); % read image     
           reference_frame=uint8(frame(:,:,:));
        end
    end
    frames_scribbles=uint8(frames_scribbles);
   
    if ((scribble_count==2) && (~isempty(reference_frame))) 
        bok=true;
    else 
        return;
    end;
    
    %----------------------------------------------------------------------
    % Task a: Filter user scribbles to indicate foreground and background   
    %----------------------------------------------------------------------

    %three binary channels, 1 means foreground-scribble
    fg_scribbles = uint8(reference_frame ~= frames_scribbles(:,:,:,1));
    %three binary channels, 1 means background-scribble
    backgroundMap = uint8(reference_frame ~= frames_scribbles(:,:,:,2));
    
    %mark pixels with a different value on one or more color channels
    fg_scribbles = uint8(fg_scribbles(:,:,1) | fg_scribbles(:,:,2) | fg_scribbles(:,:,3));
    backgroundMap = uint8(backgroundMap(:,:,1) | backgroundMap(:,:,2) | backgroundMap(:,:,3));
    
    %figure, imshow(fg_scribbles*255);
    
    %----------------------------------------------------------------------
    % Task b: Generate color models for foreground and background
    %----------------------------------------------------------------------
    
    %color histogram for the foreground scribble
    histo_fg = colHist(reference_frame(:,:,1).*fg_scribbles, reference_frame(:,:,2).*fg_scribbles, reference_frame(:,:,3).*fg_scribbles, bins);
    %color histogram for the background scribble
    histo_bg = colHist(reference_frame(:,:,1).*backgroundMap, reference_frame(:,:,2).*backgroundMap, reference_frame(:,:,3).*backgroundMap, bins);
    
end