function seg_n=keepConnected(seg,firstFrameScribbles)
    sFg = zeros(size(seg));
    sFg(:,:,1)=firstFrameScribbles;
    % connected components
    segLbl = labelmatrix(bwconncomp(seg,26)); %6,18,26
    % scribble labels
    sLbl=segLbl(sFg==1);
    sLblList=unique(sLbl(:));
    num=length(sLblList);
    % keep scribble labels
    seg_n=zeros(size(seg));
    for i=1:num
        seg_n= seg_n | (seg & (segLbl==sLblList(i)));
    end
end