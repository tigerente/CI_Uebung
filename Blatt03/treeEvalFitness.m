function fitnessVector = treeEvalFitness(forest, functionHandle)
%TREEEVALFITNESS(forest, functionHandle)
% Berechnet die Fitness von jedem Baum im Wald
% PARAMETER:
%   forest:             Wald, der bewertet werden soll
%   functionHandle:     Handle auf dei Fitnessfunktion
%
% RETURN:
%   fitnesVector:       VEktor mit Fitnesses der einzelnen Baeume

% Anzahl der Baeume
nTrees = size(population,2);

% FitnessVektor initialisieren
fitnessVector = zeros(1,nTrees);

% Fitnesses berechnen und in FitnessVektor schreiben
for i=1:nTrees
    fitnessVector(i) = fHandle(forest{i});
end

end