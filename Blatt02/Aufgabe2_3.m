% Script zur Bearbeitung von Aufgabe 2.3
clear;
tic;

% Feste Parameter:
numGenes = 12;                      % Anzahl Gene
flagAlpha = false;                   % true => Ein 'alpha'-Wert fuer alle Gene
flagDiscreteRek = false;            % false => arithmetische Rekombination 
flagSurvival = true;                % true => (lambda + my), false => (lambda,my)
fitFuncHandle = @simCar;            % Handle auf Fitnessfunktion
show = false;                        % Anzeige der Simulationsdurchläufe
fitnessLimit = Inf;                  % Abbruchbedingung fuer Fitness
                                    % Wenn ueberschritten, Algorithmus am
                                    % Ende
numGenerations = Inf;                % Anzahl Generationen

% Variable Parameter:
lambda = 3000;                        % Lambda fuer Ueberlebenskriterium
my = 1000;                             % My fuer Ueberlebenskriterium = Anzahl der Individuen
mutationRate = 30;                 % initiale Mutationsrate aller Gene
tau = 4;                          % Parameter fuer Selbstadaption wenn 0, keine Adaption
minVal = -100 *ones(1,12);              % Untere Schranke des Intervalls der Werte der Gene
maxVal = 100*ones(1,12);            % Obere Schranke des Intervalls der Werte der Gene


fitnessChangeLimit = 1;            % Abbruchbedingung fuer Aenderung der Fitness
                                    % Wert berechnet sich aus
                                    % |besteFitnessGeneration(n-1)-besteFitnessGeneration(n)|
generationsAfterLimit = 10;         % Wenn keine ausreichende Aenderung erfolgt, 
                                    % werden nochmal so viele Generationen durchlaufen

                                    
          

% Erzeugen der Startpopulation
population = generatePopulation(my, numGenes,minVal,maxVal,mutationRate);

% Startpopulation bewerten
fitness = evalFitness(population, fitFuncHandle);
% Vektor fuer Fitness der Generation vorher
fitnessOld = ones(size(population,1),1) * (-1);

% Index der Generationen
generationIndex = 1;
extraGenerationIdx = 1;

% Bestes bisher gefundenes Individuum
bestIndividuum = [zeros(1,numGenes),0];

% Generationen iterieren bis eine der Abbruchbedingungen erfuellt
while max(fitness) < fitnessLimit...
        && generationIndex <= numGenerations...
        && (abs(max(fitness)-max(fitnessOld)) > fitnessChangeLimit...
        || extraGenerationIdx < generationsAfterLimit)
    
    % Wenn keine Aenderung in Fitnesses, zusaetzliche Generationen
    % hochzaehlen
    % Wenn wieder Veraenderung kommt, Index zuruecksetzen
    if abs(max(fitness)-max(fitnessOld)) < fitnessChangeLimit
        extraGenerationIdx = extraGenerationIdx + 1;
    else
        extraGenerationIdx = 1;
    end

    
    % Neue 'lambda' Nachkommen erstellen
    offspring = reproduce(population,lambda,false,flagDiscreteRek,flagAlpha);
    
    % Nachkommen mutieren
    offspring = mutate(offspring,fitFuncHandle,tau);
    
    % My beste fuer naechste Population auswaehlen
    population = chooseMy(offspring,population,my,flagSurvival,fitFuncHandle);
    
    %Population bewerten
    fitnessOld = fitness;
    fitness = evalFitness(population, fitFuncHandle);
    
    % Bestes Individuum merken
    [maxValue, maxIdx] = max(fitness);
    if maxValue > bestIndividuum(2)
        bestIndividuum = [population(maxIdx,:),maxValue];
    end
%   
    maxValue

%     % Performancegroessen der Population 
     bestVal(generationIndex+1) = max(fitness);
%     bestArgument(generationIndex+1) = population(maxIdx,:);
     meanVal(generationIndex+1) = mean(fitness);
     worstVal(generationIndex+1) = min(fitness);
%     
    % Index hochzaehlen
    generationIndex = generationIndex+1
    
end


% % Plot aller relevanten Daten
 xValuesAlgo = 1:generationIndex;   % X-werte fuer Auswertung des Algorithmus
 %xValuesShow = linspace(0,maxVal,10000);
 figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren
% 
% % Plot der besten, mittleren und schlechtesten Fitnesswerte
 ax(1) = subplot(3,1,1);
 hold on
 plot(xValuesAlgo,bestVal,'g');
 plot(xValuesAlgo,meanVal,'b');
 plot(xValuesAlgo,worstVal,'r');
 
toc;
