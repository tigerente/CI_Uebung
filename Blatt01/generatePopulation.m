function population = generatePopulation(popSize, genSize)
% GENERATEPOPULATION:
% Erstellt eine Population in Form einer zweidimensionalen bin�ren Matrix
% In jeder Zeile steht das Genom eines Individuums mit der Laenge 'genSize'
% Parameter: 
% popSize: Anzahl der Individuen in der Population
% genSize: Groesse des Genoms eines Individuums. Gene werden zuf�llig
% gleichverteilt initialisiert.

population = randi([0,1],popSize,genSize);

end

