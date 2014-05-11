function [finalFitness, finalArgument] = algorithmAnalysis(populationSize, numGenes, flipProbability, numGenerations, numElite, flagWindowing, flagGrayCode, fitFuncHandle)
%ALGORITHMANALYSIS 
% Diese Funktion fuehrt den genetischen Algorithmus unter
% verschiedensten Bedingungen aus. Es koennen Parameter und Verfahren fuer
% den Algorithmus gewaehlt werden
% Parameter: 
%   populationSize:     Groesse der Population an
%   numGenes:           Anzahl der Gene eines Individuums
%   flipProbability:    Wahrscheinlichkeit der Mutation eines Gens
%   numGenerations:     Anzahl der Generationen
%   numElite:           Groesse der Elite (wenn numElite = 0, dann wird
%                       elitaere Selektion nicht ausgefuehrt)
%   flagWindowing:      flag-Variable. Gibt an, ob Windowing genutzt wird
%   flagGrayCode:       Gibt an, ob Genom als GrayCode interpretiert wird
%   fitFuncHandle:      FunctionHandle der Fitnessfunktion

% flagElite setzen
flagElite = false;
if numElite > 0
    flagElite = true;
end

% Startpopulartion bilden und bewerten
population = generatePopulation(populationSize,numGenes);
fitness = evalFitness(population,fitFuncHandle, flagGrayCode);

% Matrix fuer Elite
if flagElite == true;
    elite = zeros(numElite,numGenes);
end

% Generationen iterieren
for i=1:numGenerations 
    
    % Elite merken, wenn gewuenscht
    if flagElite == true
        elite = getElite(population,fitness,numElite);
    end
    
    % Folgegeneration erstellen
    population = doCrossover(population,fitness,populationSize,flagWindowing);
    
    % Population Mutieren
    mutatePopulation(population,flipProbability);
    
    % Elite zurueck in Population fuegen, wenn gewuenscht
    if flagElite == true
        population(1:numElite,:) = elite(:,:);
    end
    
    % Fitness bewerten
    fitness = evalFitness(population,fitFuncHandle,flagGrayCode);
    
end

% Besten Wert der Fitness der letzten Generation und dessen Argument
% zurueck geben
[finalFitness, index] = max(fitness);
finalArgument = getArgumentValue(population,index,flagGrayCode);

