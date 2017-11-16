clc;
clear all;
close all;
folder = pwd;
addpath(genpath(folder), '-end');
rmpath(fullfile(folder,'.git'));

% p stand for parameters
p.TrackerNum = 1;
p.TargetNum = 19;
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

%% single run
m=simulate(p);

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
