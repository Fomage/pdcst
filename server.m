clc;
clear all;
close all;
folder = pwd;
addpath(genpath(folder), '-end');
rmpath(fullfile(folder,'.git'));

% p stand for parameters
p.TrackerNum = 4;
p.TargetNum = 4;
p.ObjectiveNum = 4;
p.AgentSize=100; % Size of agents in plot
p.Dimension=2; % Select Dim
p.SizeOfEnvironment=[0 0 0;10 10 10]; % Size of Environmet (MAX(X Y Z);MIN(X Y Z))
p.speed=.05; % agents' speed
p.radius=.1; % agents' radius
p.Max_It=5000; % Max iteration of agents work
p.refreshRate=5;
p.display=true;

m=simulate(p);
