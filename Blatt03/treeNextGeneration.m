function newForest = treeNextGeneration(forest,fitness,sizes,mutateCrossoverProb,mutateProb,maxMutateDepth,descProbab,nrOp,nrTerm)
%TREENEXTGENERATION(forest, fitness, mutateCrossoverProb, mutateProb, maxMutateDepth, descProbab, nrOp, nrTerm)
% Erstellt aus einem gegebenen Wald einen neuen Wald
% Individuen werden entweder durch Mutation oder Rekombination erzeugt.
% Selektion der Eltern fitnessproportional durch Statistical Universal
% Sampling
%PARAMETER:
%   forest:                 Eltern-Wald/-Population
%   fitness:                Vektor mit Fitnesswerten der einzelnen Individuen
%   sizes:                  Vektor mit den Groessen der einzelnen Baeume
%   mutateCrossoverProb:    Wahrscheinlichkeit fuer Mutation bzw.
%                           Gegenwahrscheinlichkeit fuer Rekombination. 
%   mutateProb:             Wahrscheinlichkeit fuer Mutation eines Knotens
%   maxMutateDepth:         Maximale Tiefe von mutierten Baeumen
%   descProbab:             Abstiegswahrscheinlichkeit bei Mutation
%   nrOp:                   Anzahl der moeglichen Operatoren
%   nrTerm:                 Anzahl der moeglichen Terminale
%
% RETURN:
%   Einen neuen Wald


% neuen Wald anlegen 
newForest = cell(size(forest));

% Variable fuer naechsten freien Index im Wald
freeIdx = 1;

% Neuen Wald fuellen
while freeIdx <= size(newForest,2)
    
    % Rekombination nur, wenn noch mindestens 2 freie Plaetze in 'newForest'
    if (rand > mutateCrossoverProb) && (size(newForest,2) - freeIdx + 1 >= 2)
    
        % Eltern fitnessproportional waehlen
        [parent1 parent2] = pickParents(forest,fitness,sizes);
    
        % Rekombination der beiden Elternteile zu zwei neuen Kindern
        [newForest{freeIdx} newForest{freeIdx+1}] = treeCrossover(parent1,parent2);

        % freeIdx um 2 hochzaehlen
        freeIdx = freeIdx +2;
        
    % Ansonsten Mutation
    else
        
        % Einen Baum, der mutiert werden soll fitnessproportional auswaehlen 
        mutantParent = pickParents(forest, fitness,sizes);
        
        % Baum mutieren und in neuen Wald einfuegen
        newForest{freeIdx} = treeMutate(mutantParent,mutateProb,maxMutateDepth,descProbab,nrOp,nrTerm);
        
        % freeIdx um 1 hochzaehlen
        freeIdx = freeIdx + 1;
    end
end







end

