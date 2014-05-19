% Script zur Bearbeitung von Aufgabe 2.2.b

% Parametersetup
lambda = 15;                        % Lambda fuer Ueberlebenskriterium
my = 10;                            % My fuer Ueberlebenskriterium = Anzahl der Individuen
numGenes = 1;                       % Anzahl Gene
numGenerations = 100;               % Anzahl Generationen
mutationRate = 5;                   % initiale Mutationsrate aller Gene
tau = 1;                            % Parameter fuer Selbstadaption wenn 0, keine Adaption
minVal = [0];                       % Untere Schranke des Intervalls der Werte der Gene
maxVal = [4095];                    % Obere Schranke des Intervalls der Werte der Gene
fitFuncHandle = @fitnessFunction;   % Handle auf Fitnessfunktion
flagSurvival = false;               % true => (lambda + my), false => (lambda,my)
flagDiscreteRek = false;            % false => arithmetische Rekombination 
flagAlpha = true;                   % true => Ein 'alpha'-Wert fuer alle Gene

fitnessLimit = 1.28;                % Abbruchbedingung fuer Fitness
                                    % Wenn ueberschritten, Algorithmus am
                                    % Ende
      
fitnessChangeLimit = 0;           % Abbruchbedingung fuer Aenderung der Fitness
                                    % Wert berechnet sich aus
                                    % |besteFitnessGeneration(n-1)-besteFitnessGeneration(n)|
                                    
          

% Erzeugen der Startpopulation
population = generatePopulation(my, numGenes,minVal,maxVal,mutationRate);

% Startpopulation bewerten
fitness = evalFitness(population,fitFuncHandle);

% Vektor fuer Fitness der Generation vorher
fitnessOld = zeros(size(population,1),1);

% Index der Generation
generationIndex = 1;

% Speicher fuer Verlaufsgroessen
% Beste, mittlere und schlechteste Performance der Population
bestVal = zeros(1,generationIndex+1);
bestArgument = zeros(1,generationIndex+1);
meanVal = zeros(1,generationIndex+1);
worstVal = zeros(1,generationIndex+1);

[maxValue, maxIdx] = max(fitness);

bestVal(1) = maxValue;
bestArgument(1) = population(maxIdx,1);
meanVal(1) = mean(fitness);
worstVal(1) = min(fitness);

% Bestes bisher gefundenes Individuum
bestIndividuum = [bestArgument(1),maxValue];

% Generationen iterieren bis Abbruchbedingung erfuellt oder
% Generationslimit erreicht oder Aenderung der Fitness unter dem Limit
while (max(fitness) < fitnessLimit...
        && generationIndex <= numGenerations...
        && abs(max(fitness)- max(fitnessOld)) > fitnessChangeLimit)
    
    % Fitness auswerten bevor neue Generation erstellt wird
    % fuer Abbruchbedingung bezueglich der Aenderung der Fitness
    fitnessOld = evalFitness(population,fitFuncHandle);
    
    % Neue 'lambda' Nachkommen erstellen
    offspring = reproduce(population,lambda,false,flagDiscreteRek,flagAlpha);
    
    % Nachkommen mutieren
    offspring = mutate(offspring,fitFuncHandle,tau);
    
    % My beste fuer naechste Population auswaehlen
    population = chooseMy(offspring,population,my,flagSurvival,fitFuncHandle);
    
    % Population fuer plot bewerten
    fitness = evalFitness(population, fitFuncHandle);
    
    % Bestes Individuum merken
    [maxValue, maxIdx] = max(fitness);
    if maxValue > bestIndividuum(2)
        bestIndividuum = [population(maxIdx,1),maxValue];
    end
    
    % Performancegroessen der Population 
    bestVal(generationIndex+1) = max(fitness);
    bestArgument(generationIndex+1) = population(maxIdx,1);
    meanVal(generationIndex+1) = mean(fitness);
    worstVal(generationIndex+1) = min(fitness);
    
    % Index hochzaehlen
    generationIndex = generationIndex+1;
    
end


% Plot aller relevanten Daten
xValuesAlgo = 1:generationIndex;   % X-werte fuer Auswertung des Algorithmus
xValuesShow = linspace(0,maxVal,10000);
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren

% Plot der besten, mittleren und schlechtesten Fitnesswerte
ax(1) = subplot(3,1,1);
hold on
plot(xValuesAlgo,bestVal,'g');
plot(xValuesAlgo,meanVal,'b');
plot(xValuesAlgo,worstVal,'r');
plot(xValuesAlgo,fitFuncHandle(2000),':k');
hold off
xlabel(ax(1),'Generationen');
ylabel(ax(1),'Wert der Fitnessfunktion');
axis([1,generationIndex,0,1.5]);
axis 'auto y';
legende1 = legend('bester Fitnesswert','mittlerer Fitnesswert','schlechtester Fitnesswert','Maximum der Fitnessfunktion');
set(legende1,'Location', 'southeast');

% Plot der Argumente des besten Individuums
ax(2) = subplot(3,1,2);
hold on
plot(xValuesAlgo,bestArgument,'r');
plot(xValuesAlgo,2000,':b');
hold off
xlabel(ax(2),'Generationen');
ylabel(ax(2),'Argument für Fitnessfunktion');
axis([1,generationIndex,0,maxVal]);
legende2 = legend('Argument des besten Individuums','Optimum');
set(legende2,'Location', 'southeast');

% Plot des besten Individuums der letzten Generation auf Fitnessfunktion
% (weil es so schoen ist, das auch noch mal zu sehen)
ax(3) = subplot(3,1,3);
hold on
plot(xValuesShow,fitFuncHandle(xValuesShow),'k');
plot(bestIndividuum(1),bestIndividuum(2),'*g');
plot(bestArgument(generationIndex),bestVal(generationIndex),'*r');
hold off
xlabel(ax(3),'x');
ylabel(ax(3),'Fitnessfunktion(x)');
axis([1,maxVal,0,1.5]);
axis 'auto y';
legende3 = legend('Fitnessfunktion','bester jemals gefundener Wert','bester Wert der letzten Generation');
set(legende3,'Location', 'southeast');
