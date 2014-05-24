% Script zur Bearbeitung von Aufgabe 3.2.b

% PARAMETERSETUP:
nrTrees = 1000;                         % Anzahl der Baeume
nrGen = 20;                             % Anzahl zu evolvierender Generationen
mutateCrossoverProb = 0.5;              % Wahrscheinlichkeit fuer Mutation/Rekombination
maxStartDepth = 4;                      % Maximale initiale Tiefe der Baeume
mutateProb = 0.1;                       % Mutationswahrscheinlichkeit
maxMutateDepth = 3;                     % Maximale Tiefe der mutierten Unterbaeume
descProbab = 0.2;                       % Abstiegswahrscheinlichkeit
ops = {'( + )','( - )',' .* ',' ./ '};  % Beschreibung der Operatoren
terms = {'1','0','-1','x(1,:)'};        % Beschreibung der Terminalsymbole

% Definition der gesuchten Funktion durch ihre 
% Ein- und Ausgabedaten
nrData = 1001;
dataX = linspace(-10,10,nrData);
dataY = dataX.^3 + dataX.^2 + dataX + 1;

% Fitnessfunktion definieren
fit = @(forest) evalFitSymReg(forest,dataX,dataY,ops,terms);

