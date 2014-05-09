function population = mutatePopulation(population, flipProbability)
% MUTATEPOPULATION:
% Invertiert jedes Gen mit einstellbarer Wahrscheinlichkeit 'flipProbability'
% Parameter: 
%   population: Die Population, die mutiert werden soll
%   flipProbability: Wahrscheinlichkeit (aus [0,1]), 
%                    mit der ein Gen invertiert/mutiert wird

% Durch Population gehen
for i=1:numel(population)
   
    % mit Wahrscheinlichkeit 'flipProbability'...
    randNum = rand;
    if (randNum <= flipProbability)
        % Gene mutieren
        if (population(i) == 1)
            population(i) = 0;
        elseif (population(i) == 0)
            population(i) = 1;
        end       
    end
end

end

