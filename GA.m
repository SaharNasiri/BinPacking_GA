clc; clear all; close all;

%-------Problem Definition---------%

load('Objects.mat');

nBags = input('How many BAGS do you have?');
C = input('How much CAPACITY they have?');
Bags = ones(1, nBags)*C;

%-------Parameters---------%

maxIt = 100;
npop = 50; %No. of population
pc = 0.8; %Crossover Possibility
nc = 2*round(pc*npop/2); %No. of population created by crossover
pm = 0.2; %Mutation Possibility
nm = round(pm*npop);
mu = 0.1;

%-------Initialization---------%
for j=1:100
    empy_indv.objects = [];
    empty_indv.cost = [];
    pop = repmat(empty_indv, npop, 1);
    
    for i=1:npop
        pop(i).objects = FillingBags(Objects, Bags);
        pop(i).cost = TotalCost(pop(i).objects);
    end
    
    %sort
    Costs = [pop.cost];
    [temp, sortOrder] = sort(Costs);
    pop = pop(sortOrder);
    bestSol = pop(1);
    bestCost = zeros(maxIt, 1);
    meanCost = [];
    varCost = [];
    
    %-------Main Loop---------%
    
    
    for it=1:maxIt
        Costs = [pop.cost];
        %Crossover
        popc = repmat(empty_indv, nc, 2);
        for k=1:nc
            t = 1;
            while t
                i1 = RWS(1./Costs); %The problem is minimize
                i2 = RWS(1./Costs);
                p1 = pop(i1);
                p2 = pop(i2);
                
                [c1, c2] = BinaryCrossoverNPoint(p1.objects, p2.objects);
                t = Checker(c1, C, nBags) || Checker(c2, C, nBags);
            end
            popc(k, 1).objects = c1;
            popc(k, 2).objects = c2;
            
            popc(k, 1).cost = TotalCost(popc(k, 1).objects);
            popc(k, 2).cost = TotalCost(popc(k, 2).objects);
        end
        popc = popc(:);
        
        %Mutation
        popm = repmat(empty_indv, nm, 1);
        for k=1:nm
            i = randi([1 npop]);
            p = pop(i);
            popm(k).objects = Mutation(p.objects, mu, Bags);
            popm(k).cost = TotalCost(popm(k).objects);
        end
        
        %Merge
        pop = [popc; popm];
        Costs = [pop.cost];
        [temp, sortOrder] = sort(Costs);
        pop = pop(sortOrder);
        
        %Trunacte
        pop = pop(1:npop);
        bestSol = pop(1);
        bestCost(it) = bestSol.cost;
    end
    
    %-------Result---------%
    
%     figure;
%     plot(bestCost);
%     xlabel('Iteration');
%     ylabel('Cost');
%     hold on;
    
    meanCost = [meanCost mean(bestCost)];
    
    varCost = [varCost var(bestCost)];
    
end

figure;
plot(meanCost,'r*');
xlabel('Iteration');
ylabel('Mean/ Varians');
hold on
plot(varCost, 'b*');

disp(['Mean of Costs: ' num2str(mean(meanCost))]);
disp(['Var of Costs: ' num2str(mean(varCost))]);

