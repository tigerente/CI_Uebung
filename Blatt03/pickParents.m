function [parent1 parent2] = treePickParents(parentsPool, fitness, sizes)
%PICKPARENTS(parentsPool, fitness)
% Waehlt 2 Eltern fitnessproportional aus einem ElternPool aus
% PARAMETER:
%   parentsPool:    Cell-Array aus dem die Eltern gewaehlt werden sollen
%   fitness:        FitnessVektor der Eltern
%   sizes:          Groessen der einzelnen Baeume
%
% RETURN:
%   2 Eltern zufaellig fitnessproportional ausgewaehlt

% relative Fitnesses der Eltern
fitness = fitness/sum(fitness);

%fitness = fitness./(0.2*sizes);

% Zeile mit Identitaeten der Eltern an FitnessVektor haengen
fitness(2,:) = 1:size(fitness,2);

% Vektor nach relativer Fitness sortieren
% (transponieren => sortieren => transponieren, da Baeume in Zeile
% angeordnet)
fitness = sortrows(fitness.',-1).';

% Ersten Elternteil auswaehlen
idx = find(cumsum(fitness(1,:))>=rand);
parent1 = parentsPool{fitness(2,idx(1))};

% Zweiten Elternteil auswaehlen
idx = find(cumsum(fitness(1,:))>=rand);
parent2 = parentsPool{fitness(2,idx(1))};

end

