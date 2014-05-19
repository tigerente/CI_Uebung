function resultingFitness = algorithmAnalysis(my,lambda,tau,numGenes,minVals,maxVals,mutationRate,numGenerations,flagSurvival,flagGlobalRek,flagDiscreteRek,flagAlpha,fitFuncHandle)
%ALGORITHMANALYSIS 
% Diese Funktion fuehrt den genetischen Algorithmus unter
% verschiedensten Bedingungen aus. Es koennen Parameter und Verfahren fuer
% den Algorithmus gewaehlt werden
% Parameter: 
%   my:                 Groesse der Population
%   lambda:             Anzahl der Nachkommen vor Selektion der 'my' Besten
%   tau:                'tau'-Wert fuer Selbstadaption (wenn 0, keine
%                       Selbstadaption)
%   numGenes:           Anzahl der Gene eines Individuums
%   minVals:            Array mit unteren Grenzen jeden Genes
%   maxVals:            Array mit oberen Grenzen jeden Genes
%   mutatuionRate:      Mutationsrate
%   numGenerations:     Anzahl der Generationen
%   flagSurvival:       true => (lambda + my), false => (lambda,my)
%   flagGlobalRek:      true => Jedes Gen von zwei unterschiedliche Eltern,
%                       false => Fuer ganzes Genom nur zwei Eltern
%   flagDiscreteRek:    true => diskrete Rekombination, false => arithmetische Rekombination 
%   flagAlpha:          true => Ein 'alpha'-Wert fuer alle Gene, 
%                       false => 'alpha' fuer jedes Gen unterschiedlich
%   fitFuncHandle:      FunctionHandle der Fitnessfunktion



% Startpopulartion bilden
population = generatePopulation(my,numGenes,minVals,maxVals,mutationRate);

% Generationen iterieren
for i=1:numGenerations 
    
    % Neue 'lambda' Nachkommen erstellen
    offspring = reproduce(population,lambda,flagGlobalRek,flagDiscreteRek,flagAlpha);

    % Nachkommen mutieren
    offspring = mutate(offspring,fitFuncHandle,tau);
    
    % My beste fuer naechste Population auswaehlen
    population = chooseMy(offspring,population,my,flagSurvival,fitFuncHandle);
            
end

% Die Fitnesswerte nach Ablauf der Generationen zurueck geben
resultingFitness = evalFitness(population,fitFuncHandle);


