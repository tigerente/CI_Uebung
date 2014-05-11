function elite = getElite(population, fitnessVector, numElite)
%GETELITE
% gibt die besten Individuen von 'population' zurueck
% Parameter:
%   population: Population, aus der die Elite bestimmt werden soll
%   fitnessVector: Vektor mit Fitnesses der einzelnene Individuen von
%   'population'
%   numElite: Anzahl der Individuen, die fuer Elite ausgesucht werden
%   sollen


% Matrix duer Elite erzeugen
elite = zeros(numElite, size(population,2));

% Matrix mit Fitnesses und der zugehoerigen Identitaet (Index des
% Individuums in 'population)
eliteIdentities(:,1) = fitnessVector;
eliteIdentities(:,2) = 1:size(population,1);

% eliteIdentities nach Fitness sortieren
eliteIdentities = sortrows(eliteIdentities,-1);

% Beste Individuen aus 'population' in 'elite' schreiben
for i=1:numElite
    elite(i,:) = population(eliteIdentities(i,2),:);
end

end

