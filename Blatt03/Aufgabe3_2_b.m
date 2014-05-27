% Script zur Bearbeitung von Aufgabe 3.2 b) c) d) und e)

% PARAMETERSETUP:
nrTrees = 1000;                         % Anzahl der Baeume
nrGen = 20;                             % Anzahl zu evolvierender Generationen
mutateCrossoverProb = 0.5;              % Wahrscheinlichkeit fuer Mutation/Rekombination
maxStartDepth = 4;                      % Maximale initiale Tiefe der Baeume
mutateProb = 0.1;                       % Mutationswahrscheinlichkeit
maxMutateDepth = 3;                     % Maximale Tiefe der mutierten Unterbaeume
descProbab = 0.2;                       % Abstiegswahrscheinlichkeit
killFattest = false;                    % Soll Survival of the Fattest durch Bestrafung der Groesse unterbunden werden?
flagDataNoise = true;                  % true => Ausgabedaten (dataY) werden mit normalverteiltem Rauschen gestoert   
flagReducedData = true;                % DatenMenge reduzieren (Aufgabenteil e). Falls true, wird auch 'flagDataNoise' true gesetzt!
ops = {'( + )','( - )',' .* ',' ./ '};  % Beschreibung der Operatoren
terms = {'1','0','-1','x(1,:)'};        % Beschreibung der Terminalsymbole

nrOps = numel(ops);                     
nrTerms = numel(terms);

% 1001 gleichverteilte Daten erzeugen
nrData = 1001;
completeDataX = linspace(-10,10,nrData);  

% Definition der gesuchten Funktion durch ihre 
% Ein- und Ausgabedaten
if flagReducedData == true
    % elf gleichverteilte Zahlen aus [-10,10] ziehen
    dataX = -10 + 20 * rand(1,11);
    
    % flagDataNoise auf true setzten, da in Aufgabe e) Rauschen verlangt
    % wird
    flagDataNoise = true;
else
    dataX = completeDataX;   
end

% Ausgabedaten erzeugen
realFunction = @(x) x.^3 + x.^2 + x + 1;
dataY = realFunction (dataX);
completeDataY = realFunction(completeDataX);

% Wenn gewuenscht, AusgabeDaten mit normalverteiltem Rauschen stoeren
if flagDataNoise == true
    % Rauschen = 10% von Wertebereich von 'dataY'
    skalFac = (max(dataY)-min(dataY))*0.1;
    dataY = dataY + randn(1,size(dataX,2)) * skalFac;   
end

% Fitnessfunktion definieren
fit = @(forest) evalFitSymReg(forest,dataX,dataY,ops,terms);

% Algorithmus mit Parametern laufen lassen und Performancegroessen
% speichern
[hallOfFame, bestIndivids, meanIndivids, worstIndivids, meanSize] = ...
    gpOpt(nrTrees,nrGen,fit,nrOps,nrTerms,mutateCrossoverProb,maxStartDepth,mutateProb,maxMutateDepth,descProbab,killFattest);


% Plot der Performancegroessen
% xValuesAlgo = 1:numGenerations+1;   % X-werte fuer Auswertung des Algorithmus
% xValuesShow = linspace(0,2^numGenes,10000);
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren
xVals = 1:nrGen;

% Plot der besten, mittleren und schlechtesten Fitnesswerte
ax(1) = subplot(3,1,1);
hold on
plot(xVals,bestIndivids,'g');
plot(xVals,meanIndivids,'b');
plot(xVals,worstIndivids,'r');
hallOfFameValue=repmat(hallOfFame{2},1,nrGen);
plot(xVals,hallOfFameValue,'-.k');
hold off
xlabel(ax(1),'Generationen');
ylabel(ax(1),'Wert der Fitnessfunktion');
axis([1,nrGen,0,1.5]);
axis 'autoy y';
legende1 = legend('bester Fitnesswert','mittlerer Fitnesswert','schlechtester Fitnesswert','beste jemals gefundene Fitness');
set(legende1,'Location', 'southeast');

% Plot der Argumente des besten Individuums
ax(2) = subplot(3,1,2);
plot(xVals,meanSize,'r');
xlabel(ax(2),'Generationen');
ylabel(ax(2),'Mittlere Anzahl Blätter und Knoten');
axis([1,nrGen,0,1]);
axis 'autoy y';
legende2 = legend('Mittlere Größe der Bäume');
set(legende2,'Location', 'southeast');

% Regression plotten
nValues=size(completeDataX,2);
completeDataX=completeDataX(1:5:nValues); % Reduktion der Anzahl fuer lesbare Anzeige
completeDataY=completeDataY(1:5:nValues);

func = tree2fun(hallOfFame{1},ops,terms);
yValsReg = func (completeDataX);
ax(3) = subplot(3,1,3);
hold on
plot(completeDataX,completeDataY,'ok', 'MarkerSize', 3);
plot(dataX,dataY,'or', 'MarkerSize', 3);
plot(completeDataX,yValsReg,'b');
hold off
xlabel(ax(3),'x');
ylabel(ax(3),'y');
legende3 = legend('Ausgangsdaten', 'Datengrundlage fuer Regression', 'Regression');

% Besten Baum anzeigen
figure,treeShow(hallOfFame{1},ops,terms);

















