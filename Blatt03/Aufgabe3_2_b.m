% Script zur Bearbeitung von Aufgabe 3.2.b

% PARAMETERSETUP:
nrTrees = 100;                         % Anzahl der Baeume
nrGen = 20;                             % Anzahl zu evolvierender Generationen
mutateCrossoverProb = 0.5;              % Wahrscheinlichkeit fuer Mutation/Rekombination
maxStartDepth = 4;                      % Maximale initiale Tiefe der Baeume
mutateProb = 0.1;                       % Mutationswahrscheinlichkeit
maxMutateDepth = 3;                     % Maximale Tiefe der mutierten Unterbaeume
descProbab = 0.2;                       % Abstiegswahrscheinlichkeit
ops = {'( + )','( - )',' .* ',' ./ '};  % Beschreibung der Operatoren
terms = {'1','0','-1','x(1,:)'};        % Beschreibung der Terminalsymbole
nrOps = numel(ops);                     
nrTerms = numel(terms);


% Definition der gesuchten Funktion durch ihre 
% Ein- und Ausgabedaten
nrData = 1001;
dataX = linspace(-10,10,nrData);
dataY = dataX.^3 + dataX.^2 + dataX + 1;

% Fitnessfunktion definieren
fit = @(forest) evalFitSymReg(forest,dataX,dataY,ops,terms);

% Algorithmus mit Parametern laufen lassen und Performancegroessen
% speichern
[hallOfFame, bestIndivids, meanIndivids, worstIndivids, meanSize] = ...
    gpOpt(nrTrees,nrGen,fit,nrOps,nrTerms,mutateCrossoverProb,maxStartDepth,mutateProb,maxMutateDepth,descProbab);


% Plot der Performancegroessen
% xValuesAlgo = 1:numGenerations+1;   % X-werte fuer Auswertung des Algorithmus
% xValuesShow = linspace(0,2^numGenes,10000);
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren
xVals = 1:nrGen;

% Plot der besten, mittleren und schlechtesten Fitnesswerte
ax(1) = subplot(2,1,1);
hold on
plot(xVals,bestIndivids,'g');
plot(xVals,meanIndivids,'b');
plot(xVals,worstIndivids,'r');
plot(xVals,hallOfFame{2},'k');
hold off
xlabel(ax(1),'Generationen');
ylabel(ax(1),'Wert der Fitnessfunktion');
axis 'auto y';
legende1 = legend('bester Fitnesswert','mittlerer Fitnesswert','schlechtester Fitnesswert');
set(legende1,'Location', 'best');

% Plot der Argumente des besten Individuums
ax(2) = subplot(2,1,2);
plot(xVals,meanSize,'r');
xlabel(ax(2),'Generationen');
ylabel(ax(2),'Mittlere Größe der Bäume');
axis 'autoy y';
legende2 = legend('Mittlere Größe der Bäume');
set(legende2,'Location', 'best');

% Besten Baum anzeigen
figure,treeShow(hallOfFame{1},ops,terms);
















