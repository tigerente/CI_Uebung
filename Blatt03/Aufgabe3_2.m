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
completeDataYPure=completeDataY;

% Wenn gewuenscht, AusgabeDaten mit normalverteiltem Rauschen stoeren
if flagDataNoise == true
    % Rauschen = 10% von Wertebereich von 'dataY'
    skalFac = (max(dataY)-min(dataY))*0.1;
    dataY = dataY + randn(1,size(dataX,2)) * skalFac;
    skalFac = (max(completeDataY)-min(completeDataY))*0.1;
    completeDataY = completeDataY + randn(1,size(completeDataX,2)) * skalFac; 
end

% Fitnessfunktion definieren
fit = @(forest) evalFitSymReg(forest,dataX,dataY,ops,terms);

% Algorithmus mit Parametern laufen lassen und Performancegroessen
% speichern
[hallOfFame, bestIndivids, meanIndivids, worstIndivids, minSize, meanSize, maxSize] = ...
    gpOpt(nrTrees,nrGen,fit,nrOps,nrTerms,mutateCrossoverProb,maxStartDepth,mutateProb,maxMutateDepth,descProbab,killFattest);


% Plot der Performancegroessen
figure('units','normalized','outerposition',[0 0 1 1]) % figure maximieren
xVals = 1:nrGen;

% Plot der besten, mittleren und schlechtesten Fitnesswerte
ax(1) = subplot(2,2,1);
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
ax(2) = subplot(2,2,2);
hold on
plot(xVals,minSize,'g');
plot(xVals,meanSize,'b');
plot(xVals,maxSize,'r');
hold off
xlabel(ax(2),'Generationen');
ylabel(ax(2),'Anzahl Blätter und Knoten');
axis([1,nrGen,0,1]);
axis 'autoy y';
legende2 = legend('Minimale Größe der Bäume','Mittlere Größe der Bäume','Maximale Größe der Bäume');
set(legende2,'Location', 'north');

% Regression plotten
nValues=size(completeDataX,2);
completeDataX=completeDataX(1:5:nValues); % Reduktion der Anzahl fuer lesbare Anzeige
completeDataY=completeDataY(1:5:nValues);
completeDataYPure=completeDataYPure(1:5:nValues);

func = tree2fun(hallOfFame{1},ops,terms);
yValsReg = func (completeDataX);
ax(3) = subplot(2,2,3);
hold on
if flagReducedData == true
    plot(completeDataX,completeDataY,'ok', 'MarkerSize', 3);
else
    dataX=dataX(1:5:nValues); % Reduktion der Anzahl fuer lesbare Anzeige
    dataY=dataY(1:5:nValues);
end
plot(completeDataX,completeDataYPure,'k');
plot(dataX,dataY,'or', 'MarkerSize', 3);

plot(completeDataX,yValsReg,'b');
hold off
xlabel(ax(3),'x');
ylabel(ax(3),'y');
if flagReducedData == true
    legende3 = legend('Ausgangsdaten', 'Originalfunktion', 'Datengrundlage für Regression', 'Regression');
else
    legende3 = legend('Originalfunktion', 'Datengrundlage für Regression', 'Regression');
end
% Besten Baum anzeigen
subplot(2,2,4);
treeShow(hallOfFame{1},ops,terms);

















