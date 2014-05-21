% Script zur Bearbeitung von Aufgabe 2.1.b

% Parametersetup
%lambda = my+5;                        % Lambda fuer Ueberlebenskriterium
myMin = 8;                          % My fuer Ueberlebenskriterium = Anzahl der Individuen
myMax = 16;
numGenes = 1;                       % Anzahl Gene
numGenerations = 100;               % Anzahl Generationen
minMutationRate = 20;                % Mutationsraten aller Gene
maxMutationRate = 50;
tau = 0;                            % Parameter fuer Selbstadaption wenn 0, keine Adaption
minVal = [0];                       % Untere Schranke des Intervalls der Werte der Gene
maxVal = [4095];                    % Obere Schranke des Intervalls der Werte der Gene
fitFuncHandle = @fitnessFunction;   % Handle auf Fitnessfunktion
flagSurvival = false;               % true => (lambda + my), false => (lambda,my)
flagDiscreteRek = false;            % false => arithmetische Rekombination 
flagAlpha = true;                   % true => Ein 'alpha'-Wert fuer alle Gene
flagGlobalRek = false;              % true => Jedes Gen von unterschiedlichen Eltern
                                    % false => fuer ganzes Genom 2 Eltern

numRuns = 50;                       % Anzahl Durchlaeufe pro Parameterkonstellation: 50


% Datenfelder zur Speicherung der Auswertungsdaten
bestIndividuals = zeros(myMax-myMin, maxMutationRate/minMutationRate,numRuns);
meanIndividuals = zeros(myMax-myMin, maxMutationRate/minMutationRate,numRuns);
worstIndividuals = zeros(myMax-myMin, maxMutationRate/minMutationRate,numRuns);

bestPerformance = zeros(myMax-myMin, maxMutationRate/minMutationRate);
meanPerformance = zeros(myMax-myMin, maxMutationRate/minMutationRate);
worstPerformance = zeros(myMax-myMin, maxMutationRate/minMutationRate);



% Durchlauefe durch Parameterkonstellationen
% Anzahl Individuen variieren
for individs = myMin:myMax
   
    % Mutationsrate variieren
    for mutRate = minMutationRate:maxMutationRate
        
        % Durchlaeufe ('numRuns' gibt an, wie viele)
        for i = 1:numRuns
           
            % Algorithmus mit Parametern laufen lassen und Fitness des
            % besten gefundenen Individuums der letzten Generation abspeichern
            fitnessAfterGenerations = algorithmAnalysis(individs,individs+5,tau,numGenes,maxVal,minVal,mutRate,...
                numGenerations,flagSurvival,flagGlobalRek,flagDiscreteRek,flagAlpha,fitFuncHandle);
        
            % Verlauf ueber numRuns
            bestIndividuals(individs,mutRate,i) = max(fitnessAfterGenerations);
            meanIndividuals(individs,mutRate,i) = mean(fitnessAfterGenerations);
            worstIndividuals(individs,mutRate,i) = min(fitnessAfterGenerations);
            
        
        end      
        
        % Beste, mittlere und schlechteste Performance der aktuellen 
        % Parameterkonstellation 
        bestPerformance(individs,mutRate) = mean(bestIndividuals(individs,mutRate,:));
        meanPerformance(individs,mutRate) = mean(meanIndividuals(individs,mutRate,:));
        worstPerformance(individs,mutRate) = mean(worstIndividuals(individs,mutRate,:));
    end
    % Statusanzeige
    disp(individs);
end


% Plot
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren

% Plot des besten Fitnesswerts jeder Parameterkonstellation
ax(1) = subplot(3,1,1);
hold on
surf(bestPerformance);
hold off
xlabel(ax(1),'Mutationsrate');
ylabel(ax(1),'Anzahl Individuen');
zlabel(ax(1),'Fitness');
title(ax(1),'BESTE PERFORMANCE');

% Plot des mittleren Fitnesswerts jeder Parameterkonstellation
ax(2) = subplot(3,1,2);
hold on
surf(meanPerformance);
hold off
xlabel(ax(2),'Mutationsrate');
ylabel(ax(2),'Anzahl Individuen');
zlabel(ax(2),'Fitness');
title(ax(2),'MITTLERE PERFORMANCE');


% Plot des schlechtesten Fitnesswerts jeder Parameterkonstellation
ax(3) = subplot(3,1,3);
hold on
surf(worstPerformance);
hold off
xlabel(ax(3),'Mutationsrate');
ylabel(ax(3),'Anzahl Individuen');
zlabel(ax(3),'Fitness');
title(ax(3),'SCHLECHTESTE PERFORMANCE');

linkprop(ax,'view');





    