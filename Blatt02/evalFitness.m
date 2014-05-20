function fitnessVector = evalFitness(population, fHandle)
%EVALFITNESS 
% Ermittelt die Fitness der einzelnen Individuen. Gibt einen Vektor mit den
% Fitnesswerten der einzelnen Individuen zurueck
% Parameter:
%   population:     die Population, die bewertet werden soll
%   fHandle:        FunctionHandle auf die Fitnessfunktion

% Anzahl der Individuen
nIndivids = size(population,1);

% Anzahl der Gene (=Anzahl der Mutationsraten)
nGenes = size(population,2)/2;

% FitnessVektor initialisieren
fitnessVector = zeros(nIndivids,1);

% Fitnesses berechnen und in FitnessVektor schreiben
for i=1:size(population,1)
    fitnessVector(i) = fHandle(population(i,1:nGenes));
end

end


