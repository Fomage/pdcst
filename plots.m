%% plot targets
close all;
load('targetNumbers');
Y=zeros(20,8);
for i=1:20
%     Y(i,1)=pMat(i).targetParameters.tracker(1);
%     Y(i,2)=pMat(i).targetParameters.tracker(2);
%     Y(i,3)=pMat(i).targetParameters.target(1);
%     Y(i,4)=pMat(i).targetParameters.target(2);
%     Y(i,5)=pMat(i).targetParameters.objective(1);
%     Y(i,6)=pMat(i).targetParameters.objective(2);
%     Y(i,7)=pMat(i).targetParameters.wall(1);
%     Y(i,8)=pMat(i).targetParameters.wall(2);
%     m=max(abs(Y(i,1:2:8)));
%     Y(i,1:2:8)=Y(i,1:2:8)/m;
%     m=max(abs(Y(i,2:2:8)));
%     Y(i,2:2:8)=Y(i,2:2:8)/m;
    Y(i,1)=pMat(i).targetParameters.tracker(1);
    Y(i,2)=pMat(i).targetParameters.target(1);
    Y(i,3)=pMat(i).targetParameters.objective(1);
    Y(i,4)=pMat(i).targetParameters.wall(1);
    m=max(abs(Y(i,:)));
    Y(i,:)=Y(i,:)/m;
end
hold on;
set(gcf,'color','w');
for i=1:4
    plot(Y(:,i));
%     if mod(i,2)==0
%         plot(Y(:,i));
%     else
%         plot(Y(:,i),'--');
%     end
end
refline([0 0]);
line([2 2],[-1 1],'color',[0 0 0],'LineStyle','--');
line([6 6],[-1 1],'color',[0 0 0],'LineStyle','--');
%ylabel('u_k','FontName','cmr10');
legend('cop','yakuza','objectives','wall');
%legend('tracker2','tracker1','target2','target1','obj2','obj1','wall2','wall1');
hold off;

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
    m=max(abs(Y(i,1:2:6)));
    Y(i,1:2:6)=Y(i,1:2:6)/m;
    m=max(abs(Y(i,2:2:6)));
    Y(i,2:2:6)=Y(i,2:2:6)/m;
end
hold on;
set(gcf,'color','w');
for i=1:6
    if mod(i,2)==0
        plot(Y(:,i));
    else
        plot(Y(:,i),'--');
    end
end
refline([0 0]);
legend('tracker2','tracker1','target2','target1','wall2','wall1');
hold off;

%% simulate single point
close all;
load('targetNumbers');
p=pMat(8);
p.saveGif=true;
p.refreshRate=5;
p.display=true;
simulate(p);
