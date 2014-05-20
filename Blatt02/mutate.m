function mutatedPopulation = mutate(population, fitnessFuncHandle, tau)
%MUTATE 
% Mutiert eine Population. Zunaechst werden die Mutationsraten mutiert und
% anschliessend die Gene mit den neuen Mutationsraten.
% Hierfuer wird auf jedes Gen eine normalverteilte
% Zufallszahl addiert, die vorher mit der Mutationsrate des jeweiligen
% Genes skaliert wurde.
% Eine Mutation wird zurueck genommen, wenn die
% Fitness nicht verbessert wurde. 
% Parameter:
%   population:         Population, die mutiert werden soll
%   fitnessFuncHandle:  Handle auf die Fitnessfunktion
%   tau:                Wert fuer adaption der Mutationsraten
%                       Wenn 'tau=0', keine Adaption, da exp(0) = 1

% 'mutatedPopulation' initialisieren
mutatedPopulation = zeros(size(population));

% Zwischenspeicher fuer mutierte Population
tmpPop = zeros(size(population));

% Laenge des Gesamtgenoms, d.h. #{echte Gene} + #{Mutationsraten}
numGenes = size(population,2);

% Durch alle Individuen gehen
for i=1:size(population,1)
    % Durch alle Gene bzw. Mutationsraten gehen (Hinweis: es gibt numGenes/2 Gene und
    % numGenes/2 Mutationsraten)
    for m=1:numGenes/2
        % Zuerst Mutationrate mutieren
        tmpPop(i,m+numGenes/2) = population(i,m+numGenes/2)*exp(tau*randn);
        
        % Dann Gen, zu dem die Mutationsrate gehoert, mutieren
        tmpPop(i,m) = population(i,m) + (tmpPop(i,m+numGenes/2)*randn);
    end 
    
    % Fitness des mutierten Genoms mit unmutierter Fassung anhand Fitness
    % vergleichen
    % Wenn bessere Fitness, mutiertes Genom behalten...
    % Wenn nicht, unmutiertes Genom behalten
    if fitnessFuncHandle(tmpPop(i,1:numGenes/2)) > fitnessFuncHandle(population(i,1:numGenes/2))
        mutatedPopulation(i,:) = tmpPop(i,:);
    else
        mutatedPopulation(i,:) = population(i,:);
    end
    
end


end

