function [hallOfFame, bestIndis, meanIndis, worstIndis, meanSize] = gpOpt(nrTrees,nrGen,fitnessFkt,nrOp,nrTerm,mutateCrossoverProb,maxStartDepth,mutateProb,maxMutateDepth,descProbab)
%GPOPT(nrTrees, nrGen, fitnessFkt, nrOp, nrTerm, mutateCrossoverProb, maxStartDepth, mutateProb, maxMutateDepth, descprobab)
% Optimierungsverfahren auf Basis der genetischen Programmierung
% Es wird das Konzept der "Hall of Fame" genutzt
%
% PARAMETER:
%   nrTrees:                    Anzahl der Baeume
%   nrGen:                      Anzahl der Generationen, die evolviert werden
%   fitnessFkt:                 Die zu maximierende Fitnessfunktion als function_handle
%   nrOp:                       Anzahl der Operatoren.
%  nrTerm:                     Anzahl der Terminalsymbole.
%  mutateCrossoverProb:        Wahrscheinlichkeit fuer die Erzeugung von Nachkommen durch Mutation.
%  maxStartDepth:              Maximale Tiefe des initialen Waldes.
%  mutateProb:                 Mutationswahrscheinlichkeit jedes Knoten bzw. Blattes bei der Mutation.
%  maxMutateDepth:             Maximale Tiefe des zufaelligen Teilbaumes bei der Mutation.
%  descProbab:                 Abstiegswahrscheinlichkeit des zufaelligen Teilbaumes bei der Mutation.
%
% RETURN:
%   hallOfFame:                 Cell-Array, enthaelt:
%                               bestes Individuum (Index 1)
%                               Fitness dessen (Index 2)
%   bestIndis:                  Fitness des besten Individuums jeder
%                               Generation
%   meanIndis:                  Durchschnittliche Fitness jeder Generation
%   worstIndis:                 Fitness des schlechtesten Individuums jeder
%                               Generation
%   meanSize:                   mittlere Groesse der Baueme (Anzahl Knoten/Blaetter) 
%                               jeder Generation



% Initialen Wald erzeugen
forest = generateForest(nrTrees,maxStartDepth,descProbab,nrOp,nrTerm);

% bestes jemals gefundenes Individuum (Hall of Fame)
% in hallOfFame{1} liegt der beste je gefundene Baum
% in hallOfFame{2} steht seine Fitness
hallOfFame = cell(1,2);
hallOfFame{2} = -1;

% Speicher fuer Performancegroessen der Generationen
bestIndis = zeros(nrGen,1);
meanIndis = zeros(nrGen,1);
worstIndis = zeros(nrGen,1);
meanSize = zeros(nrGen,1);

% Generationen durchlaufen
for i=1:nrGen
    
    % Fitness des Waldes bewerten
    fitness = fitnessFkt(forest);
    
    % bestes Individuum der aktuellen Generation mit hallOfFame vergleichen
    [maxVal index] = max(fitness);
    
    if maxVal > hallOfFame{2}
       hallOfFame{1} = forest{index};
       hallOfFame{2} = maxVal; 
    end
    
    % Performancegroessen abspeichern
    bestIndis(i) = maxVal;
    meanIndis(i) = mean(fitness);
    worstIndis(i) = min(fitness);
   
    % meanSize berechnen VEKTORISIERBAR?!??!!?!
    meanVals = zeros(nrTrees,1);
    for m=1:nrTrees
        meanVals(m) = size(forest{m},1);
    end
    meanSize(i) = mean(meanVals);
    
    % naechste Generation erzeugen
    forest = treeNextGeneration(forest,fitness,mutateCrossoverProb,mutateProb,maxMutateDepth,descProbab,nrOp,nrTerm);
    
end

end

