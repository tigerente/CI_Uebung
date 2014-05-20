function population = generatePopulation(numIndivids, numGenes, minVals, maxVals, initMutationRate)
%GENERATEPOPULATION
% Erzeugt eine Population in einer Matrix. Jede Zeile der Matrix
% repreaesentiert das Genom eines Individuums. Hinter den Genen werden in
% gleicher Reihenfolge die Mutationsraten der einzelnen Gene hinterlegt.
% Jedes Gen ist eine Zufallszahl im Interval [minVals, maxVals] 
% Parameter:
%   numIndivids:        Anzahl der Individuen
%   numGenes:           Anzahl der Gene (=Anzahl der Mutationsraten)
%   minVals:            Array fuer unteren Grenzen des Intervals der Gene
%   maxVals:            Array fuer oberen Grenzen des Intervals der Gene
%   initiMutationRate:  Initiale Mutationsrate aller Gene

population = zeros(numIndivids,2*numGenes);

% Gene mit Zufallszahlen in den gegebenen Intervallen initialisieren
for i=1:numIndivids
    population(i,1:numGenes) = (maxVals-minVals).*rand(1,numGenes) + minVals;
end

% initiale Mutationsrate hinter die Gene schreiben
population(:,numGenes:end) = initMutationRate;

end

