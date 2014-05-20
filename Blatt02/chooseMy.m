function chosenMy = chooseMy(lambdaOffspring, parentsPool, numMy, flagLambdaPlusMy, fHandle)
%CHOSEMY 
% Waehlt aus Nachkommen und Eltern (je nach Ueberlebenskriterium) anhand der Fitness die 'numMy' besten
% Individuen aus und gibt sie zurueck
% Um nur beste Individuen aus einem Pool auszuwaehlen, flagLambdaPlusMy
% false setzen und leere Variable 'parentsPool' uebergeben
% Parameter:
%   lambdaOffspring:    'lambda' Nachkommen, aus denen neue Population je nach Ueberlebenskriterium entsteht 
%   parents:            ElternPool, aus denen Nachkommen entstanden sind
%                       (fuer (lambda + my)-Kriterium wichtig 
%   numMy:              Anzahl an Individuen, die ueberleben
%   flagLambdaPlusMy:   true => (lambda + my)
%                       false => (lambda,my)
%   fHandle:            functionHandle auf die Fitnessfunktion


% Wenn (lambda + my)
if flagLambdaPlusMy == true
    
    % Nachkommen und Eltern vereinen
    lambda = size(lambdaOffspring,1);
    my = size(parentsPool,1);
    allIndivids(1:lambda,:) = lambdaOffspring(:,:);
    allIndivids(lambda + 1 : lambda + my , :) = parentsPool(:,:);

% Wenn (lambda,my)
elseif flagLambdaPlusMy == false
   
    % Nur 'lambdaOffspring' bewerten
    allIndivids = lambdaOffspring;
end

% Beste 'my' Individuen anhand von Fitness auswaehlen

% Fitness berechnen
fitnessVector = evalFitness(allIndivids, fHandle);

% Zweite Spalte an FitnessVector haengen, in dem die Indizes der Individuen
% hinterlegt werden, um sie nach der Sortierung noch in 'allIndivids' zu
% finden
fitnessVector(:,2) = 1:size(allIndivids,1);

% FitnessVector absteigend sortieren
fitnessVector = sortrows(fitnessVector, -1);

% Beste Individuen in neue Matrix schreiben
chosenMy =  allIndivids(fitnessVector(1:numMy,2),:);

end

