
function exercise2(input_directory, output_directory, file_extension)
    %close all figures
    close all;  

    % check optional file extension parameter
    if (~exist('file_extension')) || (isempty(file_extension))
      file_extension='png'; 
    end
    
    % create output directory
    if ~exist(output_directory, 'dir')
       if(~mkdir(output_directory)) 
           disp(['Cannot create output directory [' output_directory ']']);
           return;
       end
    end

    % read all the file names in a folder ending on the chosen file extension
    file_list      = dir([input_directory '/*.' file_extension]); 

    if (numel(file_list) == 0)
        disp(['No input frames found in input directory ' input_directory '!'])
        return;
    end

    cnt=0;
    % add additional frame between two input frames 
    for j = 1:2:numel(file_list)-1
        firstframe = imread([input_directory '/' file_list(j).name]); %read image     
        secondframe = imread([input_directory '/' file_list(j+1).name]); %read image  
 
        %------------------------------------------------------------------
        % Task a: Compute optical flow vectors
        %------------------------------------------------------------------
        % call function get_opticalflow 
        % return parameter=get_opticalflow(parameters,...);
    
        
        %------------------------------------------------------------------
        % Task b+c: Generate new frame
        %------------------------------------------------------------------
        % call function get_inbetween_image 
        % return parameter=get_inbetween_image(parameters,...);

        cnt=cnt+1; imwrite(firstframe,  getFileName(cnt,output_directory,file_extension));
        cnt=cnt+1; imwrite(uint8(new_image),  getFileName(cnt,output_directory,file_extension));
        cnt=cnt+1; imwrite(secondframe,  getFileName(cnt,output_directory,file_extension));
    end     
end

function sName = getFileName(cnt, output_directory,file_extension)
    framecount=cnt;
    frame_number = int2str(framecount); 
    frame_str    = '00000';  
    frame_str(end-numel(frame_number)+1:end) = frame_number;  
    sName=[output_directory '/frame' frame_str '.'   file_extension];
end

