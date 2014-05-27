function [parent1 parent2] = pickParents(parentsPool, fitness, sizes, killFattest)
%PICKPARENTS(parentsPool, fitness)
% Waehlt 2 Eltern fitnessproportional aus einem ElternPool aus
% PARAMETER:
%   parentsPool:    Cell-Array aus dem die Eltern gewaehlt werden sollen
%   fitness:        FitnessVektor der Eltern
%   sizes:          Groessen der einzelnen Baeume
%   killFattest:    true: In die Selektion der Eltern fliesst neben der
%                   Fittness auch die Groesse antiproportional ein
%
% RETURN:
%   2 Eltern zufaellig fitnessproportional ausgewaehlt

% Ggf. Fitness-Reduktion entsprechend der Groesse:
if killFattest
    fitness = fitness./sizes;
end

% relative Fitnesses der Eltern
fitness = fitness/sum(fitness);

% Zeile mit Indizes der Eltern an FitnessVektor haengen
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

