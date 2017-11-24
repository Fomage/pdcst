%% clears and paths addition
clc;
clear all;
close all;
folder = pwd;
addpath(genpath(folder), '-end');
rmpath(fullfile(folder,'.git'));
%% parameters initialization
% p stand for parameters
p.TrackerNum = 4;
p.TargetNum = 8;
p.ObjectiveNum = 4;
p.AgentSize=100; % Size of agents in plot
p.Dimension=2; % Select Dim
p.SizeOfEnvironment=[0 0 0;10 10 10]; % Size of Environmet (MAX(X Y Z);MIN(X Y Z))
p.trackerParameters.speed=.05;
p.targetParameters.speed=.05;
p.radius=.1; % agents' radius
p.Max_It=5000; % Max iteration of agents work
p.refreshRate=5;
p.display=true;
p=initParameters(p);% manually sets the potentials' parameters

%% single run
m=simulate(p);

%% successive parameters optimization
optiMaxIter=20;
pMat=repmat(p,optiMaxIter);
for i=1:optiMaxIter
    [best,mean]=cmaes(p,2,16);
    p=xToP(p,mean.Position,2);
    [best,mean]=cmaes(p,1,16);
    p=xToP(p,mean.Position,1);
    pMat(i)=p;
    save('parametersOpti.mat','pMat');
end
%% optimal parameters versus target numbers
%variable targets number
p=initParameters(p);
maxTargets=10;
pMat=repmat(p,maxTargets);
for i=1:maxTargets
    disp(['number of drones: ' num2str(i)]);
    p.TargetNum=i;
    [best,mean]=cmaes(p,2,8);
    p=xToP(p,mean.Position,2);
    pMat(i)=p;
    save('targetNumbers','pMat');
end
%% single point optimization
p=initParameters(p);
maxTargets=10;
load('targetNumbers');
i=7;
disp(['number of drones: ' num2str(i)]);
p.TargetNum=i;
[best,mean]=cmaes(p,2,16);
p=xToP(p,mean.Position,2);
pMat(i)=p;
save('targetNumbers','pMat');
%% variable tracker number
p=initParameters(p);
p.TargetNum=8;
maxTrackers=10;
pMat=repmat(p,maxTrackers);
for i=1:maxTrackers
    disp(['number of drones: ' num2str(i)]);
    p.TrackerNum=i;
    [best,mean]=cmaes(p,1,8);
    p=xToP(p,mean.Position,1);
    pMat(i)=p;
    save('trackerNumbers','pMat');
end
%% map performances
p.display=false;
[X,Y]=meshgrid(1:10,1:20);
Z=zeros(20,10);
for i=1:20
    for j=1:10
        p.TrackerNum=X(i,j);
        p.TargetNum=Y(i,j);
        Z(i,j)=score(simulate(p),p);
        disp(['done ' num2str((i-1)*10+j) '/200']);
    end
end
surf(X,Y,Z);

%% genetic optimization

