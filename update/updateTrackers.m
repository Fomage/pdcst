function newTrackers = updateTrackers(trackers,targets,p)
%updateTrackers returns the new positions of trackers
newTrackers=trackers(:,:);
[trackerNum,dim]=size(trackers);
targetNum=size(targets,1);
if targetNum <= 0
    throw(MException('Finished:TrackersVictory','No more targets to catch'));
end
dim=dim-3;% ignore the team number, the current target number and the id
for i=1:trackerNum
%     targetNumber=trackers(i,dim+2);
%     target=getAgentById(targets,targetNumber);
%     if target==0
%         target=targets(1,:);
%     end
%     targetPos=target(1:dim);
%     direction=targetPos-trackers(i,1:dim);
    direction=zeros(1,dim);
    for j=1:trackerNum
        if j~=i
            direction=direction-basicGradient(p.trackerParameters.tracker,trackers(i,1:dim),trackers(j,1:dim));
        end
    end
    for j=1:targetNum
        direction=direction-basicGradient(p.trackerParameters.target,trackers(i,1:dim),targets(j,1:dim));
    end
    direction=direction+wallGradient(p.trackerParameters.wall,trackers(i,1:dim),p.SizeOfEnvironment);
    dist=norm(direction);
    if dist==0
        update=zeros(1,dim);
    else
        %update=(min(dist,speed)/dist)*direction;
        update=(p.speed/dist)*direction;
    end
    newTrackers(i,1:dim)=trackers(i,1:dim)+update;
end
end

