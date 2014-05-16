function population = generatePopulation(numIndivids, numGenes, minVals, maxVals)
%GENERATEPOPULATION
% Erzeugt eine Population in einer Matrix. Jede Zeile der Matrix
% repreaesentiert das Genom eines Individuums. Hinter den Genen werden die
% Mutationsraten der einzelnen Gene hinterlegt.
% Jedes Gen ist eine Zufallszahl im Interval [minVal, maxVal] 
% Parameter:
%   numIndivids:    Anzahl der Individuen
%   numGenes:       Anzahl der Gene und MutationsRaten
%   minVals:        Array fuer unteren Grenzen des Intervals der Gene
%   maxVals:        Array fuer oberen Grenzen des Intervals der Gene

population = zeros(numIndivids,2*numGenes);
for i=1:size(population,1)
    population(i,:) = (maxVals-minVals).*rand(1,numGenes) + minVals;
end

end

