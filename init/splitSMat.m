function [trackers,targets,objectives] = splitSMat(sMat,trackerNum,targetNum,objectiveNum)
trackers=sMat(1:trackerNum,:);
targets=sMat(trackerNum+1:trackerNum+targetNum,:);
objectives=sMat(trackerNum+targetNum+1:trackerNum+targetNum+objectiveNum,:);
end

