% Skript zu Bearbeitung von Aufgabe 1.2

% Parameter:
%   Anzahl Gene:                        12
%   Anzahl Individuen:                  16
%   flipProbability:                    0.01
%   Anzahl Generationen:                100
% Anzahl der zu behaltenden 
% Individuen bei elitaerer Selektion:   0
% (ist der Parameter = 0, wird keine elitaere Selektion durchgefuehrt)
numGenes = 12;
numIndivids = 16;
flipProbability = 0.01;
numGenerations = 100;
numElite = 0;
flagWindowing = false;
flagGrayCode = false;
fHandle = @fitnessFunction;

% Flag der Elite setzen
if numElite > 0
    flagElite = true;
else
    flagElite = false;
end

% Startpopulartion bilden und bewerten
population = generatePopulation(numIndivids,numGenes);
fitness = evalFitness(population,fHandle,flagGrayCode);

% Beste, mittlere und schlechteste Performance der Population
bestVal = zeros(1,numGenerations+1);
bestArgument = zeros(1,numGenerations+1);
meanVal = zeros(1,numGenerations+1);
worstVal = zeros(1,numGenerations+1);

[maxValue, maxIdx] = max(fitness);

bestVal(1) = maxValue;
bestArgument(1) = getArgumentValue(population,maxIdx,flagGrayCode);
meanVal(1) = mean(fitness);
worstVal(1) = min(fitness);

% Bestes bisher gefundenes Individuum
bestIndividuum = [bestArgument(1),maxValue];

% Matrix fuer Elite
if flagElite == true;
    elite = zeros(numElite,numGenes);
end

% Generationen iterieren
for i=1:numGenerations 
    
    % Elite merken
    if flagElite == true
        elite = getElite(population,fitness,numElite);
    end
    
    % Folgegeneration erstellen
    population = doCrossover(population,fitness,numIndivids,flagWindowing);
    
    % Mutieren
    population = mutatePopulation(population,flipProbability);
    
    % Elite zurueck in Population fuegen
    if flagElite == true
        population(1:numElite,:) = elite(:,:);
    end
    
    % Fitness bewerten
    fitness = evalFitness(population,fHandle,flagGrayCode);
    
    % Bestes Individuum merken
    [maxValue, maxIdx] = max(fitness);
    if maxValue > bestIndividuum(2)
        bestIndividuum = [getArgumentValue(population,maxIdx,flagGrayCode),maxValue];
    end
    
    % Performancegroessen der Population 
    bestVal(i+1) = max(fitness);
    bestArgument(i+1) = getArgumentValue(population,maxIdx(1),flagGrayCode);
    meanVal(i+1) = mean(fitness);
    worstVal(i+1) = min(fitness);
    
end


% Plot aller relevanten Daten
xValuesAlgo = 1:numGenerations+1;   % X-werte fuer Auswertung des Algorithmus
xValuesShow = linspace(0,2^numGenes,10000);
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren

% Plot der besten, mittleren und schlechtesten Fitnesswerte
ax(1) = subplot(3,1,1);
hold on
plot(xValuesAlgo,bestVal,'g');
plot(xValuesAlgo,meanVal,'b');
plot(xValuesAlgo,worstVal,'r');
plot(xValuesAlgo,fHandle(2000),':k');
hold off
xlabel(ax(1),'Generationen');
ylabel(ax(1),'Wert der Fitnessfunktion');
axis([1,numGenerations,0,1.5]);
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
axis([1,numGenerations,0,2^numGenes]);
legende2 = legend('Argument des besten Individuums','Optimum');
set(legende2,'Location', 'southeast');

% Plot des besten Individuums der letzten Generation auf Fitnessfunktion
% (weil es so schoen ist, das auch noch mal zu sehen)
ax(3) = subplot(3,1,3);
hold on
plot(xValuesShow,fHandle(xValuesShow),'k');
plot(bestIndividuum(1),bestIndividuum(2),'*g');
plot(bestArgument(numGenerations+1),bestVal(numGenerations+1),'*r');
hold off
xlabel(ax(3),'x');
ylabel(ax(3),'Fitnessfunktion(x)');
axis([1,2^numGenes,0,1.5]);
axis 'auto y';
legende3 = legend('Fitnessfunktion','bester jemals gefundener Wert','bester Wert der letzten Generation');
set(legende3,'Location', 'southeast');



