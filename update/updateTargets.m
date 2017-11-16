function newTargets = updateTargets(trackers,targets,objectives,p)
%updateTargets returns the new positions of targets
newTargets=targets(:,:);
[targetNum,dim]=size(targets);
trackerNum=size(trackers,1);
objectiveNum=size(objectives,1);
dim=dim-3;% ignore the team number and the current objective number
for i=1:targetNum
%     objectiveNumber=targets(i,dim+2);
%     objective=getAgentById(objectives,objectiveNumber);
%     objectivePos=objective(1:dim);
%     direction=objectivePos-targets(i,1:dim);
    direction=zeros(1,dim);
    for j=1:trackerNum
        direction=direction-basicGradient(p.targetParameters.tracker,targets(i,1:dim),trackers(j,1:dim));
    end
    for j=1:targetNum
        if j~=i
            direction=direction-basicGradient(p.targetParameters.target,targets(i,1:dim),targets(j,1:dim));
        end
    end
    if targets(i,dim+2)==1
        for j=1:objectiveNum-1% ignoring the base
            direction=direction-basicGradient(p.targetParameters.objective,targets(i,1:dim),objectives(j,1:dim));
        end
    elseif targets(i,dim+2)==0
        direction=direction-basicGradient(p.targetParameters.objective,targets(i,1:dim),objectives(objectiveNum,1:dim));
    end
    direction=direction+wallGradient(p.targetParameters.wall,targets(i,1:dim),p.SizeOfEnvironment);
    dist=norm(direction);
    if dist==0
        update=zeros(1,dim);
    else
        %update=(min(dist,speed)/dist)*direction;
        update=(p.targetParameters.speed/dist)*direction;
    end
    newTargets(i,1:dim)=targets(i,1:dim)+update;
end
end

