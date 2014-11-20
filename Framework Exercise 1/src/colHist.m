function count=colHist(imr,img,imb,bins)
    imr=double(imr);%*255+1;
    img=double(img);%*255+1;
    imb=double(imb);%*255+1;

    f=double(bins)/256.0;
    IDs=floor(imr*f) + floor(img*f)*bins + floor(imb*f)*bins*bins+1;
    maxID=bins^3;

    count = histc(IDs(:),1:maxID);
    %figure, bar(1:maxID,count/sum(count)), title('normal');

    fprintf('histogram check: %d=%d bins:1-%d\n', sum(count),length(imr(:)),maxID);
end

