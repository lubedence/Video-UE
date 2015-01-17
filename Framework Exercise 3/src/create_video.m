function create_video(video_filename, input_directory,file_extension)
    %---------------------------------------------------------------------
    % Task d: Create output video of all resulting frames
    %---------------------------------------------------------------------
    
    writerObj = VideoWriter(video_filename);
    writerObj.FrameRate = 24;
    open(writerObj);
    
    frame_list = dir([input_directory '/*.' file_extension]); 
    
    for j = 1:numel(frame_list)
        writeVideo(writerObj,imread([input_directory '/' frame_list(j).name])); %reads every frame to create the video
    end
    
    close(writerObj);
end

