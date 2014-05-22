function forest = generateForest(numTrees, maxDepth, descProba, nrOp, nrTerm)
%GENERATEFOREST(numTrees, macDepth, descProba, nrOp, nrTerm)
% Erzeugt eine Population an Baeumen (Forest) mit Hilfe der Funktion
% 'treeRandGenDeep'
% PARAMETER: 
%   numTrees:   Anzahl der zu erzeugenden Baeume
%   maxDepth:   Maximale Tiefe eines jeden Baumes
%   descProba:  Abstiegswahrscheinlichkeit bei der Erzeugung eines Baums
%               (wenn 1, immer vollstaendiger Baum)
%   nrOp:       Groesse der Menge der Operatoren
%   nrTerm:     Groesse der Menge der Terminalsymbole
% 
% RETURN:
%   Den Forest als Cell-Array

% Wald erzeugen
forest = {13,1};

% Forest mit Baeumen fuellen
% (Evtl spaeter noch vektorisieren, wenn moeglich?!?!)
for i=1:numTrees
    forest{i} = treeRandGenDeep(maxDepth,descProba,nrOp,nrTerm);
end

end

