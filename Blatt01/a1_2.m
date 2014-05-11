function bestIndividuum = a1_2(popSize, flipProbability, numGenerations)
%A1_2:
% Funktion zur automatisierten Auswertung der Einfluesse sich veraendernder
% Parameter
% Gibt das beste jemals gefundene Individuum/dessen Fitnesswert zurueck

numGenes = 12;
fHandle = @fitnessFunction;

% Startpopulartion bilden und bewerten
population = generatePopulation(popSize,numGenes);
fitness = evalFitness(population,fHandle);

% Bestes gefundenes Individuum
bestIndividuum = max(fitness);

% Generationen iterieren
for i=1:numGenerations
   
    % Folgegeneration erstellen
    population = doCrossover(population,fitness,popSize);
    
    % Mutieren
    mutatePopulation(population,flipProbability);
    
    % Fitness bewerten
    fitness = evalFitness(population,fHandle);
    
    % Bestes jemals gefundenes Individuum merken
    maxValue = max(fitness);
    if maxValue > bestIndividuum
        bestIndividuum = maxValue;
    end
        
end

bestIndividuum = max(fitness);

end

