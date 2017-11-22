%% plot targets
close all;
load('targetNumbers');
Y=zeros(20,8);
for i=1:20
    Y(i,1)=pMat(i).targetParameters.tracker(1);
    Y(i,2)=pMat(i).targetParameters.tracker(2);
    Y(i,3)=pMat(i).targetParameters.target(1);
    Y(i,4)=pMat(i).targetParameters.target(2);
    Y(i,5)=pMat(i).targetParameters.objective(1);
    Y(i,6)=pMat(i).targetParameters.objective(2);
    Y(i,7)=pMat(i).targetParameters.wall(1);
    Y(i,8)=pMat(i).targetParameters.wall(2);
    m=max(abs(Y(i,:)));
    Y(i,:)=Y(i,:)/m;
end
hold on;
for i=1:8
    if mod(i,2)==0
        plot(Y(:,i));
    else
        plot(Y(:,i),'--');
    end
end
legend('tracker2','tracker1','target2','target1','obj2','obj1','wall2','wall1');
refline([0 0]);

%% plot trackers
close all;
load('trackerNumbers');
Y=zeros(10,8);
for i=1:10
    Y(i,1)=pMat(i).trackerParameters.tracker(1);
    Y(i,2)=pMat(i).trackerParameters.tracker(2);
    Y(i,3)=pMat(i).trackerParameters.target(1);
    Y(i,4)=pMat(i).trackerParameters.target(2);
    Y(i,5)=pMat(i).trackerParameters.wall(1);
    Y(i,6)=pMat(i).trackerParameters.wall(2);
    m=max(abs(Y(i,:)));
    Y(i,:)=Y(i,:)/m;
end
hold on;
for i=1:6
    if mod(i,2)==0
        plot(Y(:,i));
    else
        plot(Y(:,i),'--');
    end
end
legend('tracker2','tracker1','target2','target1','wall2','wall1');
refline([0 0]);

%% simulate single point
close all;
load('targetNumbers');
p=pMat(7);
p.display=true;
p.refreshRate=1;
simulate(p);
