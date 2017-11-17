%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA108
% Project Title: Covariance Matrix Adaptation Evolution Strategy (CMA-ES)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
function [BestSol,LastMean] = cmaes(p,side,lambdaMult)
%% Problem Settings

if side==1
    CostFunction = @(x) optiFunction(p,x,pToX(p,2));
    nVar=6;
elseif side==2
    CostFunction = @(x) -optiFunction(p,pToX(p,1),x);
    nVar=8;
end

VarSize=[1 nVar];       % Decision Variables Matrix Size

VarMin=-10;             % Lower Bound of Decision Variables
VarMax= 10;             % Upper Bound of Decision Variables

%% CMA-ES Settings

% Maximum Number of Iterations
MaxIt=300;

% Termination criteria tolerance
Tol=1e-16;

% Population Size (and Number of Offsprings)
lambda=(4+round(3*log(nVar)))*lambdaMult;
disp(['lambda ' num2str(lambda)]);

% Number of Parents
mu=round(lambda/2);

% Parent Weights
w=log(mu+0.5)-log(1:mu);
w=w/sum(w);

% Number of Effective Solutions
mu_eff=1/sum(w.^2);

% Step Size Control Parameters (c_sigma and d_sigma);
sigma0=0.3*(VarMax-VarMin);
cs=(mu_eff+2)/(nVar+mu_eff+5);
ds=1+cs+2*max(sqrt((mu_eff-1)/(nVar+1))-1,0);
ENN=sqrt(nVar)*(1-1/(4*nVar)+1/(21*nVar^2));

% Covariance Update Parameters
cc=(4+mu_eff/nVar)/(4+nVar+2*mu_eff/nVar);
c1=2/((nVar+1.3)^2+mu_eff);
alpha_mu=2;
cmu=min(1-c1,alpha_mu*(mu_eff-2+1/mu_eff)/((nVar+2)^2+alpha_mu*mu_eff/2));
hth=(1.4+2/(nVar+1))*ENN;

%% Initialization

ps=cell(MaxIt,1);
pc=cell(MaxIt,1);
C=cell(MaxIt,1);
sigma=cell(MaxIt,1);

ps{1}=zeros(VarSize);
pc{1}=zeros(VarSize);
C{1}=eye(nVar);
sigma{1}=sigma0;

empty_individual.Position=[];
empty_individual.Step=[];
empty_individual.Cost=[];

M=repmat(empty_individual,MaxIt,1);
M(1).Position=unifrnd(VarMin,VarMax,VarSize);
M(1).Step=zeros(VarSize);
M(1).Cost=CostFunction(M(1).Position);

BestSol=M(1);

BestCost=zeros(MaxIt,1);

%% CMA-ES Main Loop

for g=1:MaxIt
    
    % Generate Samples
    pop=repmat(empty_individual,lambda,1);
    for i=1:lambda
        pop(i).Step=mvnrnd(zeros(VarSize),C{g});
        pop(i).Position=M(g).Position+sigma{g}*pop(i).Step;
        pop(i).Cost=CostFunction(pop(i).Position);
        
        % Update Best Solution Ever Found
        if pop(i).Cost<BestSol.Cost
            BestSol=pop(i);
        end
    end
    
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
  
    % Save Results
    BestCost(g)=BestSol.Cost;
    LastMean=M(g);
    
    % Display Results
    disp(['Iteration ' num2str(g) ': Best Cost = ' num2str(BestCost(g))]);
    %', Mean Cost = ' num2str(CostFunction(M(g).Position))
    
    % Exit At Last Iteration
    if g==MaxIt
        break;
    end

    % Update Mean
    M(g+1).Step=0;
    for j=1:mu
        M(g+1).Step=M(g+1).Step+w(j)*pop(j).Step;
    end
    M(g+1).Position=M(g).Position+sigma{g}*M(g+1).Step;
    M(g+1).Cost=CostFunction(M(g+1).Position);
    if M(g+1).Cost<BestSol.Cost
        BestSol=M(g+1);
    end
    
    % Update Step Size
    ps{g+1}=(1-cs)*ps{g}+sqrt(cs*(2-cs)*mu_eff)*M(g+1).Step/chol(C{g})';
    sigma{g+1}=sigma{g}*exp(cs/ds*(norm(ps{g+1})/ENN-1))^0.3;
    
    % Update Covariance Matrix
    if norm(ps{g+1})/sqrt(1-(1-cs)^(2*(g+1)))<hth
        hs=1;
    else
        hs=0;
    end
    delta=(1-hs)*cc*(2-cc);
    pc{g+1}=(1-cc)*pc{g}+hs*sqrt(cc*(2-cc)*mu_eff)*M(g+1).Step;
    C{g+1}=(1-c1-cmu)*C{g}+c1*(pc{g+1}'*pc{g+1}+delta*C{g});
    for j=1:mu
        C{g+1}=C{g+1}+cmu*w(j)*pop(j).Step'*pop(j).Step;
    end
    
    % If Covariance Matrix is not Positive Defenite or Near Singular
    [V, E]=eig(C{g+1});
    if any(diag(E)<0)
        E=max(E,0);
        C{g+1}=V*E/V;
    end
    
    % Termination criteria
    % NoEffectAxis
    normV=zeros(size(V));
    for i=1:nVar
        normV(i,:)=(1/norm(V(i,:)))*V(i,:);
    end
    if norm(.1*sigma{g+1}*E*normV) < Tol
        disp('NoEffectAxis');
        break
    end
    % NoEffectCoord
    b=false;
    for i=1:nVar
        if norm(.2*sigma{g+1}*C{g+1}(i,i)) < Tol
            disp('NoEffectCoord');
            b=true;
            break
        end
    end
    if b
        break
    end
    % ConditionCov
    minE=E(1,1);
    maxE=E(1,1);
    for i=2:nVar
        minE=min(minE,E(i,i));
        maxE=max(maxE,E(i,i));
    end
    if maxE/minE > 1e14
        disp('ConditionCov');
    end
    % EqualFunValue
    backwardHistoryBound=10+ceil(30*nVar/lambda);
    if g > backwardHistoryBound
        ref=BestCost(g-backwardHistoryBound);
        b=true;
        for i=1:backwardHistoryBound
            b=b && ref==BestCost(g-backwardHistoryBound+i);
        end
        if b
            disp('EqualFunValue');
            break
        end
    end
    % TolXUp
    if sigma{g+1}*maxE/sigma0 > 1e4
        disp('TolXUp');
        break
    end
end

%% Display Results

figure;
% plot(BestCost, 'LineWidth', 2);
semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

end
