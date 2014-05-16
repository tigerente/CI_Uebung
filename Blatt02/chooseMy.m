function chosenMy = chooseMy(population, fitnessVector, numMy)
%CHOSEMY 
% Waehlt aus einer Population anhand der Fitness die 'numMy' besten
% Individuen aus und gibt sie als, von Population unabhaenginge
% Matrix zurueck
% Parameter:
%   population:     Population, aus der die besten Individuen gewaehlt
%                   werden sollen
%   fitnessVector:  Vektor mit den Fitnesses der Individuen in 'population'
%   numMy:          Anzahl an Individuen, die ausgeaehlt werden sollen

% Zweite Spalte an FitnessVector haengen, in dem die Indizes der Individuen
% hinterlegt werden, um sie nach der Sortierung noch in 'population' zu
% finden
fitnessVector(:,2) = 1:size(population,1);

% FitnessVector absteigend sortieren
fitnessVector = sortrows(fitnessVector, -1);

chosenMy = zeros(numMy,size(population,2));
% Beste Individuen in neue Matrix schreiben
for i=1:numMy
    chosenMy(i,:) = population(fitnessVector(i,2),:);
end

end

