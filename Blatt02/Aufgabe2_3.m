% Script zur Bearbeitung von Aufgabe 2.3

% Parametersetup
lambda = 75;                        % Lambda fuer Ueberlebenskriterium
my = 50;                            % My fuer Ueberlebenskriterium = Anzahl der Individuen
numGenes = 12;                      % Anzahl Gene
numGenerations = 1000;              % Anzahl Generationen
mutationRate = 100;                 % initiale Mutationsrate aller Gene
tau = 1/sqrt(12);                   % Parameter fuer Selbstadaption wenn 0, keine Adaption
minVal = -10000*ones(1,12);         % Untere Schranke des Intervalls der Werte der Gene
maxVal = 10000*ones(1,12);          % Obere Schranke des Intervalls der Werte der Gene
fitFuncHandle = @simCar;            % Handle auf Fitnessfunktion
flagSurvival = true;                % true => (lambda + my), false => (lambda,my)
flagDiscreteRek = false;            % false => arithmetische Rekombination 
flagAlpha = true;                   % true => Ein 'alpha'-Wert fuer alle Gene

fitnessLimit = 50;                  % Abbruchbedingung fuer Fitness
                                    % Wenn ueberschritten, Algorithmus am
                                    % Ende
      
fitnessChangeLimit = 1;             % Abbruchbedingung fuer Aenderung der Fitness
                                    % Wert berechnet sich aus
                                    % |besteFitnessGeneration(n-1)-besteFitnessGeneration(n)|
                                    
generationsAfterLimit = 50;         % Wenn keine ausreichende Aenderung erfolgt, 
                                    % werden nochmal so viele Generationen durchlaufen
                                    
          

% Erzeugen der Startpopulation
population = generatePopulation(my, numGenes,minVal,maxVal,mutationRate);

% Startpopulation bewerten
fitness = 0;
% Vektor fuer Fitness der Generation vorher
fitnessOld = zeros(size(population,1),1);

% Index der Generationen
generationIndex = 1;
extraGenerationIdx = 1;

% Bestes bisher gefundenes Individuum
bestIndividuum = [zeros(1,numGenes),0];

% Generationen iterieren bis Abbruchbedingung erfuellt oder
% Generationslimit erreicht oder Aenderung der Fitness unter dem Limit
while (max(fitness) < fitnessLimit...
        && generationIndex <= numGenerations)...
        && ...
        (abs(max(fitness)-max(fitnessOld)) > fitnessChangeLimit...
        || extraGenerationIdx < generationsAfterLimit)
    
    % Wenn keine Aenderung in Fitnesses, zusaetzliche Generationen
    % hochzaehlen
    % Wenn wieder Veraenderung kommt, Index zuruecksetzen
    if abs(max(fitness)-max(fitnessOld)) < fitnessChangeLimit
        extraGenerationIdx = extraGenerationIdx + 1;
    else
        extraGenerationIdx = 1;
    end
    
    
    % Fitness auswerten bevor neue Generation erstellt wird
    % fuer Abbruchbedingung bezueglich der Aenderung der Fitness
    fitnessOld = evalFitness(population,fitFuncHandle);
    
    % Neue 'lambda' Nachkommen erstellen
    offspring = reproduce(population,lambda,false,flagDiscreteRek,flagAlpha);
    
    % Nachkommen mutieren
    offspring = mutate(offspring,fitFuncHandle,tau);
    
    % My beste fuer naechste Population auswaehlen
    population = chooseMy(offspring,population,my,flagSurvival,fitFuncHandle);
    
    %Population fuer plot bewerten
    fitness = evalFitness(population, fitFuncHandle);
    
    % Bestes Individuum merken
    [maxValue, maxIdx] = max(fitness);
    if maxValue > bestIndividuum(2)
        bestIndividuum = [population(maxIdx,:),maxValue];
    end
 
    % Index hochzaehlen
    generationIndex = generationIndex+1;
    
end
