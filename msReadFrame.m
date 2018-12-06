function frame = msReadFrame(ms,frameNum,columnCorrect, align, dFF)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    vidNum = ms.vidNum(frameNum);
    vidFrameNum = ms.frameNum(frameNum);    
    f = double(ms.vidObj{vidNum}.read(vidFrameNum));
    
    frame = imresize(f, [ms.vidObj{1,1}.Height ms.vidObj{1,1}.Width]);
    if (columnCorrect)
        frame = frame - ms.columnCorrection + ms.columnCorrectionOffset;
    end
    if (align)
        frame = frame(((max(ms.hShift(:,ms.selectedAlignment))+1):(end+min(ms.hShift(:,ms.selectedAlignment))-1))-ms.hShift(frameNum,ms.selectedAlignment), ...
                      ((max(ms.wShift(:,ms.selectedAlignment))+1):(end+min(ms.wShift(:,ms.selectedAlignment))-1))-ms.wShift(frameNum,ms.selectedAlignment));
    end  
    
    if (dFF)
%         idx = ms.minFrame{ms.selectedAlignment}<80;
        frame = frame./ms.minFrame{ms.selectedAlignment}-1;
%         frame = frame./ms.meanFrame{ms.selectedAlignment}-1;
%         frame(idx) = 0;
    end
    
end

