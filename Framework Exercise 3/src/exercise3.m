
function exercise3(input_directory_fg,input_directory_bg, input_directory_fg_map,output_directory, file_extension)
    % close all figures
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
 
    % read all the file names in a folder ending on the choosen file extension
    file_list_fg      = dir([input_directory_fg '/*.' file_extension]); 

    if (numel(file_list_fg) == 0)
        disp(['No input frames for foreground found in input directory ' input_directory '!'])
        return;
    end
    
    file_list_bg      = dir([input_directory_bg '/*.' file_extension]); 

    if (numel(file_list_bg) == 0)
        disp(['No input frames for background found in input directory ' input_directory '!'])
        return;
    end
    
    file_list_fg_map      = dir([input_directory_fg_map '/*.' file_extension]); 

    if (numel(file_list_fg_map) == 0)
        disp(['No input frames for foreground map found in input directory ' input_directory '!'])
        return;
    end
    
    if (numel(file_list_fg) ~= numel(file_list_bg) ) || (numel(file_list_fg) ~= numel(file_list_fg_map) ) || (numel(file_list_bg) ~= numel(file_list_fg_map) )  
        disp(['The number of background frames differ from foreground frames!'])
        return;
    end

    cnt=0;
    for j = 1:numel(file_list_fg)
        fg = imread([input_directory_fg '/' file_list_fg(j).name]); %read image  
        bg = imread([input_directory_bg '/' file_list_bg(j).name]); %read image  
        foreground_map=imread([input_directory_fg_map '/' file_list_fg_map(j).name]);  
        foreground_map=foreground_map/255; %binary map    
        
        %------------------------------------------------------------------
        % Task a: Adjust brightness and resize foreground object
        %------------------------------------------------------------------
        
        %------------------------------------------------------------------
        % Task b: Add shadow of foreground object to background
        %------------------------------------------------------------------
        % call function add_shadow 
        % return parameter=add_shadow(parameters,...);
        
        %------------------------------------------------------------------
        % Task c: Merge foreground and background
        %------------------------------------------------------------------
        % call function merge 
        % return parameter=merge(parameters,...);
       
        cnt=cnt+1; imwrite(result,  getFileName(cnt,output_directory,file_extension)); 
    end    
    
    %------------------------------------------------------------------
    % Task d: create output video
    %------------------------------------------------------------------
    % call function create_video 
    % create_video(parameters,...);
end

function sName = getFileName(cnt, output_directory,file_extension)
    framecount=cnt;
    frame_number = int2str(framecount); 
    frame_str    = '00000';  
    frame_str(end-numel(frame_number)+1:end) = frame_number;  
    sName=[output_directory '/frame' frame_str '.'   file_extension];
end
