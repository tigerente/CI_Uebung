% Dieses Skript befasst sich mit dem Aufgabenteil 1.2.d

% Es wird einmal das Standardverfahren des Genetischen Algorithmus genutzt,
% einmal mit Zuhilfenahme der Strategie "Windowing" und einmal mit der
% Strategie "Elitaere Selektion":
% Getestet wird fuer die normale Fitnessfunktion und fuer die selbe mit 
% einem Offset von 100.
% Der betrachtete Fitnesswert fuer die Auswertung ist immer der beste Wert
% der letzten Generation. Dieser ist ein Indikator, wie gut das jeweilige
% Verfahren gegen das Maximum der Fitnessfunktion konvergiert

% Zu Auswertung wird jedes Verfahren mit den folgenden Parametern getestet:
popSize = 40;                       % Populationsgroesse
nGenes = 12;                        % Anzahl an Genen eines Individuums
flipProba = 0.1;                    % Mutationswahrscheinlichkeit
nGenerations = 100;                 % Anzahl Generationene
nElite = 4;                         % Groesse der Elite
numRuns = 200;                      % Anzahl Runs pro Verfahren
flagGrayCode = false;               % Genom interpretieren als GrayCode?
fHandleNormal = @fitnessFunction;   % Fitnessfunktion normal
fHandleOffset = @fitnessFunction_2; % Fitnessfunktion mit Offset 100

% Definitionen der Cluster der Funktion:
% linkes Cluster aus x=[0,1900]
% mittleres Cluster aus x=[1900,2100]
% rechtes Cluster aus x=[2100,4096]
% Grenzen des mittleren Cluster (andere Grenzen ergeben sich daraus)
midMin = 1900;
midMax = 2100;


% Speichermatrizen fuer Test des Standardverfahrens
resultValuesSTD = zeros(numRuns,1);      
resultArgumentsSTD = zeros(numRuns,1);
resultValuesOffsetSTD = zeros(numRuns,1);
resultArgumentsOffsetSTD = zeros(numRuns,1);

% Speichermatrizen fuer Test mit Windowing
resultValuesWINDOW = zeros(numRuns,1);      
resultArgumentsWINDOW = zeros(numRuns,1);
resultValuesOffsetWINDOW = zeros(numRuns,1);
resultArgumentsOffsetWINDOW = zeros(numRuns,1);

% Speichermatrizen fuer Test mit elitaerer Selektion
resultValuesELITE = zeros(numRuns,1);      
resultArgumentsELITE = zeros(numRuns,1);
resultValuesOffsetELITE = zeros(numRuns,1);
resultArgumentsOffsetELITE = zeros(numRuns,1);

% Ausfuehren der Algorithmen mit jeweiligen Parametern/Verfahren
for i=1:numRuns
   
    % Standardverfahren
    [resultValuesSTD(i), resultArgumentsSTD(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,0,false,flagGrayCode,fHandleNormal);
    [resultValuesOffsetSTD(i), resultArgumentsOffsetSTD(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,0,false,flagGrayCode,fHandleOffset);
    
    % mit Windowing
    [resultValuesWINDOW(i), resultArgumentsWINDOW(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,0,true,flagGrayCode,fHandleNormal);
    [resultValuesOffsetWINDOW(i), resultArgumentsOffsetWINDOW(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,0,true,flagGrayCode,fHandleOffset);
    
    % mit elitaerer Selektion
    [resultValuesELITE(i), resultArgumentsELITE(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,nElite,false,flagGrayCode,fHandleNormal);
    [resultValuesOffsetELITE(i), resultArgumentsOffsetELITE(i)] = algorithmAnalysis(popSize,nGenes,flipProba,nGenerations,nElite,false,flagGrayCode,fHandleOffset);
    
end


% Einordnung der Ergebnisse in Cluster der Funktion
nClusterSTD = clusterAnalysis(resultArgumentsSTD,0,midMin,midMin,midMax,midMax,4096);
nClusterWINDOW = clusterAnalysis(resultArgumentsWINDOW,0,midMin,midMin,midMax,midMax,4096);
nClusterELITE = clusterAnalysis(resultArgumentsELITE,0,midMin,midMin,midMax,midMax,4096);

nClusterOffsetSTD = clusterAnalysis(resultArgumentsOffsetSTD,0,midMin,midMin,midMax,midMax,4096);
nClusterOffsetWINDOW = clusterAnalysis(resultArgumentsOffsetWINDOW,0,midMin,midMin,midMax,midMax,4096);
nClusterOffsetELITE = clusterAnalysis(resultArgumentsOffsetELITE,0,midMin,midMin,midMax,midMax,4096);

% Plot, wie oft welches Cluster getroffen wurde
figure
% Standardverfahren auf normaler Fitnessfunktion
ax(1) = subplot(3,2,1);
bar(nClusterSTD);
set(ax(1),'XTick',[1 2 3]);
set(ax(1),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(1),'STANDARDVERFAHREN');
ylabel(ax(1),'Anzahl Treffer');

% Standardverfahren mit Windowing auf normaler Fitnessfunktion
ax(2) = subplot(3,2,3);
bar(nClusterWINDOW);
set(ax(2),'XTick',[1 2 3]);
set(ax(2),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(2),'WINDOWING');
ylabel(ax(2),'Anzahl Treffer');

% Standardverfahren mit Elitism auf normaler Fitnessfunktion
ax(3) = subplot(3,2,5);
bar(nClusterELITE);
set(ax(3),'XTick',[1 2 3]);
set(ax(3),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(3),'ELITISM');
ylabel(ax(3),'Anzahl Treffer');

% Standardverfahren auf Fitnessfunktion mit Offset
ax(4) = subplot(3,2,2);
bar(nClusterOffsetSTD);
set(ax(4),'XTick',[1 2 3]);
set(ax(4),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(4),'STANDARD + OFFSET');
ylabel(ax(4),'Anzahl Treffer');

% Standardverfahren mit Windowing auf Fitnessfunktion mit Offset
ax(5) = subplot(3,2,4);
bar(nClusterOffsetWINDOW);
set(ax(5),'XTick',[1 2 3]);
set(ax(5),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(5),'WINDOWING + OFFSET');
ylabel(ax(5),'Anzahl Treffer');

% Standardverfahren mit Elitism auf Fitnessfunktion mit Offset
ax(6) = subplot(3,2,6);
bar(nClusterOffsetELITE);
set(ax(6),'XTick',[1 2 3]);
set(ax(6),'XTickLabel','linkes Cluster|mittleres Cluster|rechtes Cluster');
title(ax(6),'ELITISM + OFFSET');
ylabel(ax(6),'Anzahl Treffer');







