function fitnessVector = evalFitness(population, fHandle)
%EVALFITNESS 
% Ermittelt die Fitness der einzelnen Individuen. Gibt einen Vektor mit den
% Fitnesswerten der einzelnen Individuen zurueck
% Parameter:
%   population:     die Population, die bewertet werden soll
%   fHandle:        FunctionHandle auf die Fitnessfunktion


% FitnessVektor initialisieren
fitnessVector = zeros(size(population,1),1)

% Fitnesses berechnen und in FitnessVektor schreiben
for i=1:size(population,1)
    fitnessVector(i,1) = fHandle(population(i,1:(size(population,2)/2)));
end

end


