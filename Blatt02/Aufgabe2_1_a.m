% Script zur Bearbeitung von Aufgabe 2.1.a

% Parametersetup
lambda = 15;                        % Lambda fuer Ueberlebenskriterium
my = 10;                            % My fuer Ueberlebenskriterium = Anzahl der Individuen
numGenes = 1;                       % Anzahl Gene
numGenerations = 1;               % Anzahl Generationen
mutationRate = 5;                   % initiale Mutationsrate aller Gene
tau = 1;                            % Parameter fuer Selbstadaption wenn 0, keine Adaption
minVal = [0];                       % Untere Schranke des Intervalls der Werte der Gene
maxVal = [4095];                    % Obere Schranke des Intervalls der Werte der Gene
fitFuncHandle = @fitnessFunction;   % Handle auf Fitnessfunktion
flagSurvival = false;               % true => (lambda + my), false => (lambda,my)
flagDiscreteRek = false;            % false => arithmetische Rekombination 
flagAlpha = true;                   % true => Ein 'alpha'-Wert fuer alle Gene
          

% Erzeugen der Startpopulation
population = generatePopulation(my, numGenes,minVal,maxVal,mutationRate);

% Startpopulation bewerten
fitness = evalFitness(population,fitFuncHandle);

% Speicher fuer Verlaufsgroessen
% Beste, mittlere und schlechteste Performance der Population
bestVal = zeros(1,numGenerations+1);
bestArgument = zeros(1,numGenerations+1);
meanVal = zeros(1,numGenerations+1);
worstVal = zeros(1,numGenerations+1);

[maxValue, maxIdx] = max(fitness);

bestVal(1) = maxValue;
bestArgument(1) = population(maxIdx,1);
meanVal(1) = mean(fitness);
worstVal(1) = min(fitness);

% Bestes bisher gefundenes Individuum
bestIndividuum = [bestArgument(1),maxValue];

% Generationen iterieren
for i=1:numGenerations 
       
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
    bestVal(i+1) = max(fitness);
    bestArgument(i+1) = population(maxIdx,1);
    meanVal(i+1) = mean(fitness);
    worstVal(i+1) = min(fitness);
    
end


% Plot aller relevanten Daten
xValuesAlgo = 1:numGenerations+1;   % X-werte fuer Auswertung des Algorithmus
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
axis([0,numGenerations,0,1.5]);
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
ylabel(ax(2),'Argument fuer Fitnessfunktion');
axis([0,numGenerations,0,maxVal]);
legende2 = legend('Argument des besten Individuums','Optimum');
set(legende2,'Location', 'southeast');

% Plot des besten Individuums der letzten Generation auf Fitnessfunktion
% (weil es so schoen ist, das auch noch mal zu sehen)
ax(3) = subplot(3,1,3);
hold on
plot(xValuesShow,fitFuncHandle(xValuesShow),'k');
plot(bestIndividuum(1),bestIndividuum(2),'*g');
plot(bestArgument(numGenerations+1),bestVal(numGenerations+1),'*r');
hold off
xlabel(ax(3),'x');
ylabel(ax(3),'Fitnessfunktion(x)');
axis([0,maxVal,0,1.5]);
axis 'auto y';
legende3 = legend('Fitnessfunktion','bester jemals gefundener Wert','bester Wert der letzten Generation');
set(legende3,'Location', 'southeast');
