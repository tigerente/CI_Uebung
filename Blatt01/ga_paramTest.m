% Skript zur Bearbeitung von Aufgabe 1.2.b

% Parameter
minNumIndivids = 2;     % Anzahl Individuen: 2 bis 16
maxNumIndivids = 16;

numGenes = 12;                      % Anzahl der Gene in Genom
numElite = 0;                       % Groesse der Elite fuer elitism (wenn 0, kein elitism)
flagWindowing = false;              % Soll Windowing genutzt werden?
flagGrayCode = false;               % Soll Genom als GrayCode interpretiert werden?
functionHandle = @fitnessFunction;  % Handle von Fitnessfunktion

minFlipProba = 0.001;   % flipProbability: 0.001 bis 0.1
maxFlipProba = 0.1;

numGenerations = 100;   % Anzahl Generationen 100
numRuns = 50;           % Anzahl Durchlaeufe pro Parameterkonstellation: 50


% datenfelder zur Speicherung der Auswertungsdaten
bestIndividuals = zeros(numRuns,1);
bestPerformance = zeros(maxNumIndivids-minNumIndivids, maxFlipProba/minFlipProba);
meanPerformance = zeros(maxNumIndivids-minNumIndivids, maxFlipProba/minFlipProba);
worstPerformance = zeros(maxNumIndivids-minNumIndivids, maxFlipProba/minFlipProba);



% Durchlauefe durch Parameterkonstellationen
% Individuen variieren
for individs = minNumIndivids:maxNumIndivids
   
    % flipProbability variieren
    flipProbaIndex = 1;
    for flipProba = minFlipProba:minFlipProba:maxFlipProba
        
        % Durchlaeufe ('numRuns' gibt an, wie viele)
        for i = 1:numRuns
            
            % Algorithmus mit Parametern laufen lassen und Fitness des
            % besten gefundenen Individuums der letzten Generation abspeichern
            [bestIndividuals(i),notOfInterest] = algorithmAnalysis(individs,numGenes,flipProba,numGenerations,numElite,flagWindowing,flagGrayCode,functionHandle);
        end      
        
        % Beste, mittlere und schlechteste Performance der aktuellen 
        % Parameterkonstellation 
        bestPerformance(individs,flipProbaIndex) = max(bestIndividuals);
        meanPerformance(individs,flipProbaIndex) = mean(bestIndividuals);
        worstPerformance(individs,flipProbaIndex) = min(bestIndividuals);
        flipProbaIndex = flipProbaIndex+1;
    end
end


% Plot
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren

% Achsen fuer Plot
xAxis = minNumIndivids:maxNumIndivids;
yAxis = minFlipProba:minFlipProba:maxFlipProba;

% Plot des besten Fitnesswerts jeder Parameterkonstellation
ax(1) = subplot(3,1,1);
hold on
surf(bestPerformance);
hold off
set(ax(1),'XTick',[1 10 20 30 40 50 60 70 80 90 100]);
set(ax(1),'XTickLabel','0.001|0.01|0.02|0.03|0.04|0.05|0.06|0.07|0.08|0.09|0.1');
xlabel(ax(1),'Mutationswahrscheinlichkeit');
ylabel(ax(1),'Anzahl Individuen');
zlabel(ax(1),'Fitness');
title(ax(1),'BESTE PERFORMANCE');

% Plot des mittleren Fitnesswerts jeder Parameterkonstellation
ax(2) = subplot(3,1,2);
hold on
surf(meanPerformance);
hold off
set(ax(2),'XTick',[1 10 20 30 40 50 60 70 80 90 100]);
set(ax(2),'XTickLabel','0.001|0.01|0.02|0.03|0.04|0.05|0.06|0.07|0.08|0.09|0.1');
xlabel(ax(2),'Mutationswahrscheinlichkeit');
ylabel(ax(2),'Anzahl Individuen');
zlabel(ax(2),'Fitness');
title(ax(2),'MITTLERE PERFORMANCE');


% Plot des schlechtesten Fitnesswerts jeder Parameterkonstellation
ax(3) = subplot(3,1,3);
hold on
surf(worstPerformance);
hold off
set(ax(3),'XTick',[1 10 20 30 40 50 60 70 80 90 100]);
set(ax(3),'XTickLabel','0.001|0.01|0.02|0.03|0.04|0.05|0.06|0.07|0.08|0.09|0.1');
xlabel(ax(3),'Mutationswahrscheinlichkeit');
ylabel(ax(3),'Anzahl Individuen');
zlabel(ax(3),'Fitness');
title(ax(3),'SCHLECHTESTE PERFORMANCE');

linkprop(ax,'view');





    