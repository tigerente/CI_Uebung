function newForest = treeNextGeneration(forest,fitness,mutateCrossoverProb,mutateProb,maxMutateDepth,descProb,nrOp,nrTerm)
%TREENEXTGENERATION(forest, fitness, mutateCrossoverProb, mutateProb, maxMutateDepth, descProbab, nrOp, nrTerm)
% Erstellt aus einem gegebenen Wald einen neuen Wald
% Individuen werden entweder durch Mutation oder Rekombination erzeugt.
% Selektion der Eltern fitnessproportional durch Statistica Universal
% Sampling
%PARAMETER:
%   forest:                 Eltern-Wald/-Population
%   fitness:                Vektor mit Fitnesswerten der einzelnen Individuen
%   mutateCrossoverProb:    Wahrscheinlichkeit fuer Mutation bzw.
%                           Gegenwahrscheinlichkeit fuer Rekombination. 
%   mutateProb:             Wahrscheinlichkeit fuer Mutation eines Knotens
%   maxMutateDepth:         Maximale Tiefe von mutierten Baeumen
%   descProb:               Abstiegswahrscheinlichkeit bei Mutation
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
    if (rand > mutateCrossoverProb) && (size(newForest,2) - freeIdx - 1 >= 2)
    
        % Eltern fitnessproportional waehlen
        
    
    
        % freeIdx um 2 hochzaehlen
        freeIdx = freeIdx +2;
        
    % Ansonsten Mutation
    else
    
    
    
    end
end







end

